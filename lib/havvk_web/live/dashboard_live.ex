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

        <%= for {appKey, appDetails} <- @versions do %>
          <tr>
            <td>app: <%= appKey %></td>
             <%!-- works! amazing --%>
            <td class={@versions["app1"]["dev"]}><%= appDetails["dev"] %></td>
             <%!-- also works, great --%>
            <td class={@versions[appKey]["dev"]}>using vars</td>
             <%!-- also works! --%>
            <td class={appDetails["dev"]}>using no @</td>

            <td class="bg-amber-500"><%= appDetails["qa"] %></td>

            <td><%= appDetails["prod"] %></td>
             <%!--  --%>
          </tr>
        <% end %>
      </table>

      <table class="table-auto border-collapse border border-green-800 m-4">
        <%= for _ <- 1..3 do %>  <%!-- 3 rows --%>
          <tr>
            <%= for _ <- 1..3 do %>  <%!--  3 cols --%>
              <td class="border border-green-600 p-2">
                <table class="table-auto border-collapse border border-blue-500 w-full">
                 <%= for nested_id <- 1..3 do %>  <%!--  3 rows (1 col) per cell --%>
                    <tr>
                        <td class="border border-blue-300 p-1 text-center"><%= nested_id %></td>
                    </tr>
                  <% end %>
                </table>
              </td>
            <% end %>
          </tr>
        <% end %>
      </table>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        current_time: DateTime.utc_now(),
        versions: DashboardData.get_versions_mocked()
      )

    IO.inspect(socket)
    IO.puts("checking socket assigns, added versions")

    {:ok, socket}
  end
end
