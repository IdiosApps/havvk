defmodule Havvk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HavvkWeb.Telemetry,
      # Start the Ecto repository
      Havvk.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Havvk.PubSub},
      # Start Finch
      {Finch, name: Havvk.Finch},
      # Start the Endpoint (http/https)
      HavvkWeb.Endpoint,
      # Start a worker by calling: Havvk.Worker.start_link(arg)
      # {Havvk.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Havvk.MockServer, options: [port: 8081]}
    ]

    # children = case args do
    #   [env: :prod] -> base
    #   [env: :test] -> base ++ [{Plug.Cowboy, scheme: :http, plug: Havvk.MockServer, options: [port: 8081]}]
    #   [env: :dev] -> base ++ [{Plug.Cowboy, scheme: :http, plug: Havvk.MockServer, options: [port: 8081]}]
    #   [] -> base
    # end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Havvk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HavvkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
