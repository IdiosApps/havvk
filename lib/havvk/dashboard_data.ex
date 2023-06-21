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

  # def get_versions_mocked_v2() do
  #   x = %{
  #     "app1" => %{
  #       "dev" => %{
  #         "version" => 2,
  #       },
  #       "qa" => %{
  #         "version" => 2,
  #       },
  #       "prod" => %{
  #         "version" => 2,
  #       }
  #     },
  #     "app2" => %{
  #       "dev" => %{
  #         "version" => 2,
  #       },
  #       "qa" => %{
  #         "version" => 1,
  #       },
  #       "prod" => %{
  #         "version" => 1,
  #       }
  #     }
  #   }

  #   IO.puts("v2 mocked versions")
  #   IO.inspect(x)
  #   IO.inspect(x["app1"])
  #   IO.inspect(x["app1"]["dev"])
  #   IO.inspect(x["app1"]["dev"]["color"])

  # end
end
