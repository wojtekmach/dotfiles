if System.get_env("M") && :mix not in Enum.map(Application.loaded_applications(), &elem(&1, 0)) do
  Mix.install([
    :decimal,
    {:req, path: "~/src/req"},
    {:system_castore, path: "~/src/system_castore"},
    {:easyxml, path: "~/src/easyxml", override: true},
    :saxmerl,
    :floki
  ])
end
