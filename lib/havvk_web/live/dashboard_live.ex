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
        <%= for {app, env, version} <- @versions do %>
           <p>app: <%= app %>, env: <%= env %>, v: <%= version %></p>
        <% end %>

      </table>

    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       current_time: DateTime.utc_now(),
       versions: DashboardData.get_versions_random()
     )}
  end
end
1
