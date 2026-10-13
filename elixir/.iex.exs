# Application.put_env(:elixir, :dbg_callback, {MyDbg, :dbg, [:stdio]})
#
#

# defmodule MyDbg do
#   def dbg(code, _options, _caller, device) do
#     path = Application.app_dir(:wx, "priv/erlang-logo128.png")
#     encoded = File.read!(path) |> Base.encode64()

#     output =
#       "\e]1337;File=name=#{Path.basename(path)};inline=1;width=auto;height=auto:#{encoded}\a"

#     quote do
#       result = unquote(code)
#       IO.puts(unquote(output))
#       IO.inspect(unquote(device), result, label: unquote(Macro.to_string(code)))
#     end
#   end
# end

# Code.prepend_path("/Users/wojtek/src/batteries/_build/dev/lib/batteries/ebin")
# Code.prepend_path("/Users/wojtek/src/batteries/_build/dev/lib/ezstd/ebin")

# import Batteries
# Inspect.Opts.default_inspect_fun(&Batteries.__inspect__/2)

# Inspect.Opts.default_inspect_fun(fn term, opts ->
#   # :io.format("~p~n", [opts])
#   Inspect.inspect(term, opts)
# end)

# defmodule WojtekHelpers do
#   def url(string, options \\ []) do
#     options =
#       if options[:query] do
#         update_in(options[:query], &URI.encode_query(&1, :rfc3986))
#       else
#         options
#       end

#     struct!(URI.new!(string), options)
#   end
# end

# import WojtekHelpers

IEx.configure(default_prompt: "iex>")
# use_if_available(Unit.Operators)

# defmodule Hi do
#   def hi do
#     :mister
#   end
# end

# defmodule Ho do
#   def hi do
#     :mister
#   end
# end
