#! /usr/bin/env elixir

defmodule Main do
  def main(args) do
    switches = [
      metadata: :boolean,
      doc: :boolean
    ]

    {opts, args} = OptionParser.parse!(args, strict: switches)

    case args do
      ["docs", what] ->
        case Code.string_to_quoted(what) do
          {:ok, {{:., _, [module, name]}, _, []}} ->
            docs_mfa(module(module), name, :any, opts)

          {:ok, {:/, _, [{{:., _, [module, name]}, _, []}, arity]}} ->
            docs_mfa(module(module), name, arity, opts)

          {:ok, module} ->
            docs_module(module(module), opts)
        end

      ["spec", what] ->
        case Code.string_to_quoted(what) do
          {:ok, {{:., _, [module, name]}, _, []}} ->
            spec_mfa(module(module), name, :any, opts)

          {:ok, {:/, _, [{{:., _, [module, name]}, _, []}, arity]}} ->
            spec_mfa(module(module), name, arity, opts)
        end
    end
  end

  defp module(atom) when is_atom(atom), do: atom
  defp module({:__aliases__, _, parts}), do: Module.concat(parts)

  @colors [
    atom: :cyan,
    string: :green,
    list: :default_color,
    boolean: :magenta,
    nil: :magenta,
    tuple: :default_color,
    binary: :default_color,
    map: :default_color
  ]

  defp docs_module(module, opts) do
    {:docs_v1, _anno, _language, _format, doc, metadata, _docs} = Code.fetch_docs(module)

    data = [
      metadata: metadata,
      doc: doc(doc)
    ]

    data =
      if Keyword.get(opts, :metadata, true) == false do
        Keyword.delete(data, :metadata)
      else
        data
      end

    data =
      if Keyword.get(opts, :doc, true) == false do
        Keyword.delete(data, :doc)
      else
        data
      end

    IO.inspect(data, syntax_colors: @colors)
  end

  defp docs_mfa(module, name, arity, opts) do
    {:docs_v1, _anno, _language, _format, _doc, _metadata, docs} = Code.fetch_docs(module)

    for {{_, ^name, an_arity}, _anno, signature, doc, metadata} <- docs,
        arity in [:any, an_arity] do
      data = [
        signature: signature,
        metadata: metadata,
        doc: doc(doc)
      ]

      data =
        if Keyword.get(opts, :metadata, true) == false do
          Keyword.delete(data, :metadata)
        else
          data
        end

      data =
        if Keyword.get(opts, :doc, true) == false do
          Keyword.delete(data, :doc)
        else
          data
        end

      IO.inspect(data,
        syntax_colors: @colors
      )
    end
  end

  defp doc(%{"en" => doc}), do: doc
  defp doc(other), do: other

  defp spec_mfa(module, name, arity, _opts) do
    {:docs_v1, _anno, language, _format, _doc, _metadata, _docs} = Code.fetch_docs(module)

    ac =
      case :code.get_object_code(module) do
        {^module, binary, _file} ->
          case :beam_lib.chunks(binary, [:abstract_code]) do
            {:ok, {_, [{:abstract_code, {_vsn, abstract_code}}]}} -> abstract_code
            _otherwise -> []
          end

        :error ->
          []
      end

    for {:attribute, _, kind, x} = ast <- ac do
      case kind do
        :spec ->
          {{a_name, an_arity}, _} = x

          if name == a_name and arity in [:any, an_arity] do
            pp_typespec(language, ast)
          end

        :type ->
          {a_name, _, args} = x
          an_arity = length(args)

          if name == a_name and arity in [:any, an_arity] do
            pp_typespec(language, ast)
          end

        _ ->
          :ok
      end
    end
  end

  defp pp_typespec(:elixir, {:attribute, _, :spec, {{name, _}, ast}}) do
    for ast <- ast do
      Code.Typespec.spec_to_quoted(name, ast)
      |> Macro.to_string()
      |> Code.format_string!()
      |> IO.puts()
    end
  end

  defp pp_typespec(:elixir, {:attribute, _, :type, ast}) do
    ast
    |> Code.Typespec.type_to_quoted()
    |> Macro.to_string()
    |> Code.format_string!()
    |> IO.puts()
  end

  defp pp_typespec(:erlang, ast) do
    IO.puts(:erl_pp.attribute(ast))
  end
end

Main.main(System.argv())
