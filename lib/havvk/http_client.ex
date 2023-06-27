defmodule Havvk.HttpClient do
  @local_base_url "localhost:8081"

  def get_version_remote(base_url) do
    IO.puts("getting remote version")
    url = base_url <> "/version"
    options = [timeout: 200]

    HTTPoison.get(url, [], options)
    |> handle_response
  end

  def get_version_local() do
    HTTPoison.get(@local_base_url <> "/version")
    |> handle_response
  end

  defp handle_response(resp) do
    case resp do
      {:ok, %{body: body, status_code: 200}} ->
        body
        |> Jason.decode!()
        |> Map.get("version")

      {:error, %HTTPoison.Error{reason: :econnrefused, id: nil}} ->
        "unavailable"

      {:error, %HTTPoison.Error{reason: :timeout, id: nil}} ->
        "timed out"
    end
  end
end
