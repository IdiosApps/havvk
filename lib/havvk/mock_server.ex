# https://medium.com/flatiron-labs/rolling-your-own-mock-server-for-testing-in-elixir-2cdb5ccdd1a0#
defmodule Havvk.MockServer do
  use Plug.Router

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Poison

  plug :match
  plug :dispatch

  get "/version" do
    version =
      case Application.get_env(:havvk, :env) do
        :test -> "v123"
        :dev -> "v" <> Integer.to_string(Enum.random(1..100))
      end

    # case conn.params do
    # %{"name" =>"success-repo"} ->
    # Could add fields like env, region, buildTimestamp, etc.
    success(conn, %{:version => version, :name => "some-app"})
    # %{"name" =>"failure-repo"} ->
    #   failure(conn)
    # end
  end

  defp success(conn, body) do
    conn
    |> Plug.Conn.send_resp(200, Poison.encode!(body))
  end

  # defp failure(conn) do
  #   conn
  #   |> Plug.Conn.send_resp(422, Poison.encode!(%{message: "error message"}))
  # end
end
