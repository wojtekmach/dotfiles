if :mix not in Enum.map(Application.loaded_applications(), &elem(&1, 0)) do
  Mix.install([
    # :decimal,
    # {:req, path: "~/src/req"},
    # {:system_castore, path: "~/src/system_castore"},
    # {:easyxml, path: "~/src/easyxml", override: true},
    # :saxmerl,
    # :floki,
    {:sigils, path: "~/src/sigils"}
  ])
end

defmodule MyInspect do
  import Inspect.Algebra

  def inspect(%URI{} = url, _opts) do
    concat(["~URI[", URI.to_string(url), "]"])
  end

  def inspect(%Date.Range{step: 1} = range, _opts) do
    "~Date.Range[#{range.first}..#{range.last}]"
  end

  def inspect(%Date.Range{} = range, _opts) do
    "~Date.Range[#{range.first}..#{range.last}//#{range.step}]"
  end

  def inspect(term, opts) do
    Inspect.inspect(term, opts)
  end
end

Inspect.Opts.default_inspect_fun(&MyInspect.inspect/2)

# import Sigils
