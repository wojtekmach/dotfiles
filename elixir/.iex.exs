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
