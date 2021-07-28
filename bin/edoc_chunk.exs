#! /usr/bin/env elixir

defmodule Main do
  def main(args) do
    {opts, args} = OptionParser.parse!(args, strict: [pretty_print: :string])

    case args do
      [path] ->
        module = Path.basename(path, ".erl") |> String.to_atom()
        :ok = erlc(module, File.read!(path))

        case Code.fetch_docs(module) do
          {:docs_v1, _, _, _, _, _, _} = chunk ->
            case Keyword.get(opts, :pretty_print, "elixir") do
              "elixir" ->
                IO.inspect(chunk)
              "erlang" ->
                :io.format("~p~n", [chunk])
            end
        end

      _ ->
        IO.puts("Usage: edoc_chunk PATH/TO/MODULE.erl")
        System.halt(1)
    end
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
        :debug_info,
        outdir: String.to_charlist(ebin_dir)
      ])

    true = Code.prepend_path(ebin_dir)
    {:module, ^module} = :code.load_file(module)
    edoc_to_chunk(module)
    :ok
  end

  def edoc_to_chunk(module) do
    source_path = module.module_info(:compile)[:source]
    dir = :filename.dirname(source_path)

    :ok =
      :edoc.files([source_path],
        preprocess: true,
        doclet: :edoc_doclet_chunks,
        layout: :edoc_layout_chunks,
        dir: dir ++ '/doc'
      )
  end
end

Main.main(System.argv())
