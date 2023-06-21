defmodule Havvk.DashboardData do
  def get_versions_random() do
    applications = ["app1", "app2"]
    environments = ["dev", "qa", "prod"]

    data =
      Enum.reduce(applications, [], fn app, acc ->
        Enum.reduce(environments, acc, fn env, acc ->
          random_number = :rand.uniform(2)
          [{app, env, random_number} | acc]
        end)
      end)

    IO.inspect(data)
    data
  end
end
