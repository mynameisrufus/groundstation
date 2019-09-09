defmodule GroundStationWeb.MapLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div id="map"></div>
    <div
      type="hidden"
      data-latitude="<%= @latitude %>"
      data-longitude="<%= @longitude %>"
      phx-hook="Map"
    >
    Map
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok, put_position(socket, 133, -151)}
  end

  def handle_event("update", %{"latitude" => latitude, "longitude" => longitude}, socket) do
    {:noreply, put_position(socket, latitude, longitude)}
  end

  defp put_position(socket, latitude, longitude) do
    assign(socket, latitude: latitude, longitude: longitude)
  end
end
