# Havvk

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

# Testing

http://localhost:8081/
Cowboy lightweight server serves a plug. Currently returns "Hello, world!", in all envs.
Aiming for test, dev only

It starts with the rest of the app when `mix phx.server` is called.
https://medium.com/flatiron-labs/rolling-your-own-mock-server-for-testing-in-elixir-2cdb5ccdd1a0 was a very helpful starting point.

`mix test test\havvk\http_client_test`

# Dev

## If it's not working

```shell
mix deps.clean -all
mix deps.get
mix deps.compile
```
