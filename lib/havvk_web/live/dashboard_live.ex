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
           <td style="background-color: {get_colour(envVersions["dev"])};"><%= envVersions["dev"] %></td>
           <td><%= envVersions["qa"] %></td>
           <td><%= envVersions["prod"] %></td>

           <div class="<%= random_color_class() %>">
  <p>This element has a random background color.</p>
</div>

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

    IO.puts("checking socket assigns, added versions")
    IO.inspect(socket.assigns)

    {:ok, socket}
  end

  defp get_style(version) do
    colour = get_colour(version)

    "background-color: #{colour}"
  end

# 150 green
# 151 red
# 152 blue
  defp get_colour(version) do
    colours =
      Enum.shuffle([
        # purple
        "#9C9BC4",
        # peach
        "#C49C9B",
        "#9CC49B",
        # green
        "#9BC49C",
        # peach
        "#C49B9C"
      ])

    index = rem(version, length(colours))
    colours[index]
  end

  def random_color_class() do
    colors = ["bg-red-500", "bg-blue-500", "bg-green-500", "bg-yellow-500"]
    random_index = :rand.uniform(length(colors))
    List.at(colors, random_index)
  end

end
