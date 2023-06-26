defmodule Havvk.MockServer do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello, world!")
  end
end

# defmodule Havvk.MockServer do
#   use Plug.Router
#   plug Plug.Parsers, parsers: [:json],
#                     pass:  ["text/*"],
#                     json_decoder: Poison

#   plug :match
#   plug :dispatch

#   post "/repos" do
#     case conn.params do
#       %{"name" =>"success-repo"} ->
#         success(conn, %{"id" => 1234, "name" => "success-repo"})
#       %{"name" =>"failure-repo"} ->
#         failure(conn)
#     end
#   end

#   defp success(conn, body \\ "") do
#     conn
#     |> Plug.Conn.send_resp(200, Poison.encode!(body))
#   end

#   defp failure(conn) do
#     conn
#     |> Plug.Conn.send_resp(422, Poison.encode!(%{message: "error message"}))
#   end
# end
