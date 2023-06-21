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
        <%= for {app, envVersions} <- @versions do %>
          <tr>
           <td>app: <%= app %></td>
           <td>v. dev: <%= envVersions["dev"] %></td>
           <td>v. qa: <%= envVersions["qa"] %></td>
           <td>v. prod: <%= envVersions["prod"] %></td>
          </tr>
        <% end %>
      </table>
    </div>
    """
  end

  def mount(_params, _session, socket) do

    socket = assign(
      socket,
      current_time: DateTime.utc_now(),
      versions: DashboardData.get_versions_mocked()
    )

    IO.puts("checking socket assigns, added versions")
    IO.inspect(socket.assigns)

    {:ok, socket}
  end
end
