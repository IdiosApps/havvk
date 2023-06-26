defmodule Havvk.HttpClient do
  @base_url "localhost:8081"

  def get_version() do
    HTTPoison.get(@base_url <> "/version")
    |> handle_response
  end

  defp handle_response(resp) do
    case resp do
      {:ok, %{body: body, status_code: 200}} ->
        body
        |> Jason.decode!()
        |> Map.get("version")
      # {:ok, %{body: body, status_code: 422}} ->
      #   %{error_message: message}
    end
  end
end
