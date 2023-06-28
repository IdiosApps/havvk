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
      <table>
        <tr>
          <th>Application</th>

          <th>dev</th>

          <th>qa</th>

          <th>prod</th>
        </tr>

        <%= for {app, envs} <- @versions do %>
          <tr>
            <td><%= app %></td>
            <%= for {env, regions} <- Map.to_list(envs) |> sortEnvs do %>
              <td>
                <%= for {region, details} <- Map.to_list(regions) |> sortRegions do %>
                  <ul>
                    <li class={details["color"]}>
                      <%= details["version"] %>, colour: <%= details["color"] %> Region: <%= region %> env: <%= env %>
                    </li>
                  </ul>
                <% end %>
              </td>
            <% end %>
          </tr>
        <% end %>
      </table>
    </div>
    """
  end

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
        versions: DashboardData.get_versions_by_http()
      )

    IO.inspect(socket)
    IO.puts("checking socket assigns, added versions")

    {:ok, socket}
  end
end
