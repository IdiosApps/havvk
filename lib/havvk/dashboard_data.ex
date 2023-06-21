defmodule Havvk.DashboardData do
  def get_versions_mocked() do
    %{
      "app1" => %{
        "dev" => 2,
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
end
