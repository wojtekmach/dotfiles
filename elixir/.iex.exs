if System.get_env("M") do
  Mix.install([
    :decimal,
    {:req, path: "/Users/wojtek/src/req"},
    {:system_castore, path: "/Users/wojtek/src/system_castore"}
  ])
end
