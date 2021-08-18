#! /usr/bin/env elixir

defmodule Main do
  def main(args) do
    {opts, args} = OptionParser.parse!(args, strict: [pretty: :string])

    case args do
      [erl_path] ->
        module = erlc(erl_path)
        :ok = docgen(module)

        case Code.fetch_docs(module) do
          {:docs_v1, _, _, _, _, _, _} = chunk ->
            case Keyword.get(opts, :pretty, "elixir") do
              "elixir" ->
                IO.inspect(chunk)

              "erlang" ->
                :io.format("~p~n", [chunk])
            end
        end

      _ ->
        IO.puts("Usage: docgen PATH/TO/MODULE.erl")
        System.halt(1)
    end
  end

  def erlc(path) do
    module = Path.basename(path, ".erl") |> String.to_atom()
    erlc(module, File.read!(path))
  end

  def erlc(module, code) do
    dir = System.tmp_dir!()

    src_path = Path.join([dir, "#{module}.erl"])
    src_path |> Path.dirname() |> File.mkdir_p!()
    File.write!(src_path, code)

    ebin_dir = Path.join(dir, "ebin")
    File.mkdir_p!(ebin_dir)

    {:ok, module} =
      :compile.file(String.to_charlist(src_path), [
        :return_errors,
        :debug_info,
        outdir: String.to_charlist(ebin_dir)
      ])

    true = Code.prepend_path(ebin_dir)
    {:module, ^module} = :code.load_file(module)
    module
  end

  defp docgen(module) do
    erl_path = module.module_info(:compile)[:source]
    [xml] = docs(erl_path)

    beam_path = :code.which(module)

    xml_dir = :filename.join([:filename.dirname(beam_path), '..', 'doc', 'xml'])
    xml_path = :filename.join(xml_dir, '#{module}.xml')
    File.mkdir_p!(xml_dir)
    File.write!(xml_path, xml)

    chunk_dir = :filename.join([:filename.dirname(beam_path), '..', 'doc', 'chunks'])
    chunk_path = :filename.join(chunk_dir, '#{module}.chunk')
    File.mkdir_p!(chunk_dir)

    args = ["app", xml_path, beam_path, "", chunk_path]
    :ok = :docgen_xml_to_chunk.main(args)
  end

  defp docs(path) do
    for {_, _, 0, ['% @xml' | lines]} <- :erl_comment_scan.file(path) do
      lines = ['% <?xml version="1.0" encoding="utf-8" ?>\n' | lines]
      doc(lines)
    end
  end

  defp doc(lines) do
    lines
    |> Enum.map(fn
      '%' -> ?\n
      '% ' ++ rest -> [rest, ?\n]
    end)
    |> :erlang.iolist_to_binary()
  end
end

Main.main(System.argv())
