defmodule Havvk.DashboardData do
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
    x = %{
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

    a = %{}
    b = Map.put_new(a, "myKey", "myValue")
    IO.inspect(b)



    for {app, envs} <- x do
      for {env, regions} <- Map.to_list(envs) do
        for {region, details} <- Map.to_list(regions) do
          IO.puts("setting color")
          details = Map.put_new(details, "color", "bg-red-100")
          IO.inspect(details)
        end
      end
    end

    IO.puts("v2 mocked versions")
    IO.inspect(x)
    IO.inspect(x["app1"])
    IO.inspect(x["app1"]["dev"])
    IO.inspect(x["app1"]["dev"]["us-east-1"])
    IO.inspect(x["app1"]["dev"]["us-east-1"]["color"])
    IO.inspect(x["app1"]["dev"]["us-east-1"]["version"])

    x
  end
end
