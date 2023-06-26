defmodule HavvkWeb.DashboardLive do
  use Phoenix.LiveView

  alias Havvk.DashboardData

  def render(assigns) do
    ~H"""
    <div>
      <h1>Hello, LiveView!</h1>

      <p>Current time: <%= @current_time %></p>
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
          <%= for {env, details} <- Map.to_list(envs) |> sortEnvs do %>

              <td class={details["color"]}> v<%= details["version"] %>, colour: <%= details["color"] %> </td>

          <% end %>
        </tr>
        <% end %>


      </table>

      <%!-- Need to load in colours once so they render dynamically with the tailwind class? --%>
      <td class="bg-amber-300"> hello</td>
      <td class="bg-purple-300"> world</td>
      <td class="bg-teal-300"> world</td> --%>
    </div>
    """
  end

def sortEnvs(list) do
  order = ["dev", "qa", "prod"]
  Enum.sort_by(list, fn {env, _} -> Enum.find_index(order, &(&1 == env)) end)
end

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        current_time: DateTime.utc_now(),
        versions: DashboardData.get_versions_mocked_v2()
      )

    IO.inspect(socket)
    IO.puts("checking socket assigns, added versions")

    {:ok, socket}
  end
end
