#! /usr/bin/env elixir

defmodule Main do
  @usage """
  Usage:

      docs_chunk.exs MODULE.erl [OPTIONS]

  Options:

      --pretty     how to pretty-print, can be `elixir` or `erlang`, defaults to `elixir`
      --moduledoc  whether to only print module doc content, defaults to `false`

  Example with edoc:

  Source:

      $ cat edoc_example.erl
      %% @doc
      %% {@link erlang}
      -module(mod).
      -export([f/0]).

      -spec f() -> ok.
      f() -> ok.

  Output:

      $ docs_chunk.exs edoc_example.erl
      [
        {:a, [href: "erlang", rel: "https://erlang.org/doc/link/seeerl"],
         [{:code, [], ["erlang"]}]}
      ]

  Example with erl_docgen:

  Source:

      %% @xml
      %% <!DOCTYPE erlref SYSTEM "erlref.dtd">
      %% <erlref>
      %%   <module since="">docgen_example</module>
      %%   <description>
      %%      <seeerl marker="erlang"><c>erlang</c></seeerl>
      %%   </description>
      %%   <funcs>
      %%     <func>
      %%       <name name="f" arity="0" since=""/>
      %%     </func>
      %%   </funcs>
      %% </erlref>
      -module(docgen_example).
      -export([f/0]).

      -spec f() -> ok.
      f() -> ok.

  Output:

      $ docs_chunk.exs docgen_example.erl --moduledoc
      [
        {:a, [href: "erlang", rel: "https://erlang.org/doc/link/seeerl"],
         [{:code, [], ["erlang"]}]}
      ]
  """

  @switches [
    pretty: :string,
    moduledoc: :boolean
  ]

  def main(args) do
    {opts, args} = OptionParser.parse!(args, strict: @switches)

    case args do
      [erl_path] ->
        module = erlc(erl_path)

        code = File.read!(erl_path)

        if code =~ "%% @doc") do
          :ok = edoc(module)
        end

        if code =~ "%% @xml" do
          :ok = docgen(module)
        end

        case Code.fetch_docs(module) do
          {:docs_v1, _, _, _, _, _, _} = chunk ->
            chunk
            |> filter_chunk(opts)
            |> pretty(opts)
        end

      _ ->
        IO.write(@usage)
        System.halt(1)
    end
  end

  defp filter_chunk(chunk, opts) do
    if opts[:moduledoc] do
      {:docs_v1, _, _, _, %{"en" => moduledoc}, _, _} = chunk
      moduledoc
    else
      chunk
    end
  end

  defp pretty(doc, opts) do
    case Keyword.get(opts, :pretty, "elixir") do
      "elixir" ->
        IO.inspect(doc)

      "erlang" ->
        :io.format("~p~n", [doc])
    end
  end

  defp erlc(path) do
    module = Path.basename(path, ".erl") |> String.to_atom()
    erlc(module, File.read!(path))
  end

  defp erlc(module, code) do
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

    case docs(erl_path) do
      [xml] ->
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

  defp edoc(module) do
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
