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

## Erlang, Elixir, mix setup (MacOS, Linux)
- [Install asdf](https://asdf-vm.com/guide/getting-started.html) `brew install asdf`
- `asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git`
- `asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`
- `asdf install erlang 25.3 && asdf local erlang 25.3`
- `asdf install elixir 1.15.0-otp-25 && asdf local elixir 1.15.0-otp-25`
- In case `eixir -v` doesn't report your Elixir & Erlang versions: `echo 'export PATH="$HOME/.asdf/shims:$PATH"' >> ~/.zshrc`
- `mix local.hex --force`
- `mix do deps.get, clean, compile`

## Erlang, Elixir, mix setup (Windows)

https://elixir-lang.org/install.html#windows


## Running the app

`mix phx.server`


## If it's not working

```shell
mix deps.clean -all
mix deps.get
mix deps.compile
```

## Docker

[`mix phx.gen.release --docker --no-ecto`](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Release.html)

Here are some useful release commands you can run in any release environment:

    # To build a release
    mix release

    # To start your system with the Phoenix server running
    _build/dev/rel/havvk/bin/server

    # To run migrations
    _build/dev/rel/havvk/bin/migrate

Once the release is running you can connect to it remotely:

    _build/dev/rel/havvk/bin/havvk remote
