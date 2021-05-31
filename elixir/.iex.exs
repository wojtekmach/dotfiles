if System.get_env("M") && :mix not in Enum.map(Application.loaded_applications(), &elem(&1, 0)) do
  Mix.install([
    :decimal,
    {:mint, path: "~/src/mint", override: true},
    {:req, path: "/Users/wojtek/src/req"},
    {:system_castore, path: "/Users/wojtek/src/system_castore"}
  ])
end
