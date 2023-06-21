defmodule HavvkWeb.DashboardLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~H"""
    <div>
      <h1>Hello, LiveView!</h1>
      <p>Current time: <%= @current_time %></p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, current_time: DateTime.utc_now())}
  end


end
