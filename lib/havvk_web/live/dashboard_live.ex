defmodule HavvkWeb.DashboardLive do
  use Phoenix.LiveView

  alias Havvk.DashboardData

  def render(assigns) do
    ~H"""
    <div>
      <%!-- Need to load in colours once so they render dynamically with the tailwind class? --%>
      <div hidden>
        <td class="bg-rose-300">hello</td>
        <td class="bg-cyan-300">world</td>
        <td class="bg-amber-300">wow</td>
        <td class="bg-emerald-300">wow</td>
        <td class="bg-violet-300">universe</td>
        <td class="bg-slate-300">2.0</td>
      </div>
      <%!-- <p>Versions: <%= @versions %></p> --%>
      <table class="w-full text-center table-auto">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-4 py-2">Application</th>
            <th class="px-4 py-2">dev</th>
            <th class="px-4 py-2">qa</th>
            <th class="px-4 py-2">prod</th>
          </tr>
        </thead>
        <tbody>
          <%= for {app, envs} <- @versions do %>
            <tr>
              <td class="border px-4 py-2"><%= app %></td>
              <%= for {_env, regions} <- Map.to_list(envs) |> sortEnvs do %>
                <td class="border px-4 py-2">
                  <%= for {_region, details} <- Map.to_list(regions) |> sortRegions do %>
                    <p class={"px-4 py-2 " <> details["color"]}>
                      <%= details["version"] %>
                    </p>
                  <% end %>
                </td>
              <% end %>
            </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  @spec sortEnvs(any) :: list
  def sortEnvs(list) do
    order = ["dev", "qa", "prod"]
    Enum.sort_by(list, fn {env, _} -> Enum.find_index(order, &(&1 == env)) end)
  end

  def sortRegions(list) do
    order = ["us-east-1", "us-east-2", "eu-west-1"]
    Enum.sort_by(list, fn {env, _} -> Enum.find_index(order, &(&1 == env)) end)
  end

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        versions: DashboardData.get_versions_mocked_v2()
      )

    {:ok, socket}
  end
end
