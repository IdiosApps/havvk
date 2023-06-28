defmodule Havvk.DashboardData do
  alias Havvk.HttpClient

  def get_versions_mocked() do
    %{
      "app1" => %{
        "dev" => "bg-blue-500",
        "qa" => 2,
        "prod" => 2
      },
      "app2" => %{
        "dev" => 2,
        "qa" => 1,
        "prod" => 1
      }
    }
  end

  def get_versions_mocked_v2() do
    %{
      "app1" => %{
        "dev" => %{
          "us-east-1" => %{"version" => 1},
          "us-east-2" => %{"color" => "bg-teal-300", "version" => 2},
          "eu-west-1" => %{"color" => "bg-teal-300", "version" => 3}
        },
        "qa" => %{
          "us-east-1" => %{"color" => "bg-blue-500", "version" => 2},
          "us-east-2" => %{"color" => "bg-blue-500", "version" => 2},
          "eu-west-1" => %{"color" => "bg-blue-500", "version" => 2}
        },
        "prod" => %{
          "us-east-1" => %{"color" => "bg-blue-500", "version" => 2},
          "us-east-2" => %{"color" => "bg-blue-500", "version" => 2},
          "eu-west-1" => %{"color" => "bg-blue-500", "version" => 2}
        }
      }
    }
  end

  @spec get_versions_by_http :: map
  def get_versions_by_http() do
    apps = ["app1", "app2"]
    envs = ["dev", "qa", "prod"]
    regions = ["us-east-1", "us-east-2", "eu-west-1"]

    result =
      for app <- apps, into: %{} do
        {
          app,
          for env <- envs, into: %{} do
            {
              env,
              for region <- regions, into: %{} do
                version =
                  case Application.get_env(:havvk, :env) do
                    env when env in [:test, :dev] ->
                      HttpClient.get_version_local()

                    _ ->
                      ("https://" <> app <> "-" <> env <> "-" <> region <> ".my-org.net")
                      |> HttpClient.get_version_remote()
                  end

                color =
                  case version do
                    "v1" -> "bg-rose-300"
                    "v2" -> "bg-cyan-300"
                    "v3" -> "bg-amber-300"
                    "v4" -> "bg-emerald-300"
                    "v5" -> "bg-violet-300"
                    _ -> "bg-blueGray-300"
                  end

                {region, %{"version" => version, "color" => color}}
              end
            }
          end
        }
      end

    IO.inspect(result)
    result
  end

  def get_versions_by_http_parallel() do
    apps = ["app1", "app2"]
    envs = ["dev", "qa", "prod"]
    regions = ["us-east-1", "us-east-2", "eu-west-1"]

    tasks =
      for app <- apps, env <- envs, region <- regions do
        Task.async(fn ->
          version =
            case Application.get_env(:havvk, :env) do
              env when env in [:test, :dev] ->
                HttpClient.get_version_local()

              _ ->
                ("https://" <> app <> "-" <> env <> "-" <> region <> ".my-org.net")
                |> HttpClient.get_version_remote()
            end

          color =
            case version do
              "v1" -> "bg-rose-300"
              "v2" -> "bg-cyan-300"
              "v3" -> "bg-amber-300"
              "v4" -> "bg-emerald-300"
              "v5" -> "bg-violet-300"
              _ -> "bg-blueGray-300"
            end

          {app, env, region, version, color}
        end)
      end

    results = tasks |> Enum.map(&Task.await/1)

    result_map =
      Enum.reduce(results, %{}, fn {app, env, region, version, color}, acc ->
        Map.update(
          acc,
          app,
          %{env => %{region => %{"version" => version, "color" => color}}},
          fn existing ->
            Map.update(
              existing,
              env,
              %{region => %{"version" => version, "color" => color}},
              fn existing_env ->
                Map.put(existing_env, region, %{"version" => version, "color" => color})
              end
            )
          end
        )
      end)

    IO.inspect(result_map)
    result_map
  end
end
