# if :mix not in Enum.map(Application.loaded_applications(), &elem(&1, 0)) do
#   Mix.install([
#     :decimal,
#     {:req, path: "~/src/req"},
#     {:easyxml, path: "~/src/easyxml"},
#     {:easyhtml, path: "~/src/easyhtml"}
#   ])
# end

Application.put_env(:elixir, :dbg_callback, {Macro, :dbg, []})
