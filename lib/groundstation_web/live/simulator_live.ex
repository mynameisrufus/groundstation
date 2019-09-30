defmodule GroundStationWeb.SimulatorLive do
  use Phoenix.LiveView

  @tick 15
  @tick_seconds @tick / 1000

  def render(assigns) do
    Phoenix.View.render(GroundStationWeb.PageView, "simulator.html", assigns)
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(@tick, self(), :tick)

    {:ok,
     assign(socket, simulator: %FlightSimulator{location: %{lat: -33.8688, lng: 151.2093}})}
  end

  def handle_info(:tick, socket) do
    socket.assigns.simulator
    |> FlightSimulator.update(@tick_seconds)
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => code}, socket)
      when code in ["ArrowLeft", "KeyA"] do
    socket.assigns.simulator
    |> FlightSimulator.roll_left()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => code}, socket)
      when code in ["ArrowRight", "KeyD"] do
    socket.assigns.simulator
    |> FlightSimulator.roll_right()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => code}, socket)
      when code in ["ArrowUp", "KeyW"] do
    socket.assigns.simulator
    |> FlightSimulator.pitch_down()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => code}, socket)
      when code in ["ArrowDown", "KeyS"] do
    socket.assigns.simulator
    |> FlightSimulator.pitch_up()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => "Minus"}, socket) do
    socket.assigns.simulator
    |> FlightSimulator.speed_down()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => "Equal"}, socket) do
    socket.assigns.simulator
    |> FlightSimulator.speed_up()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => "Comma"}, socket) do
    socket.assigns.simulator
    |> FlightSimulator.yaw_left()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => "Period"}, socket) do
    socket.assigns.simulator
    |> FlightSimulator.yaw_right()
    |> update_simulator(socket)
  end

  def handle_event("control_input", %{"code" => "Space"}, socket) do
    socket.assigns.simulator
    |> FlightSimulator.reset_attitude()
    |> update_simulator(socket)
  end

  def handle_event("control_input", _key, socket) do
    {:noreply, socket}
  end

  def update_simulator(state, socket) do
    {:noreply, assign(socket, :simulator, state)}
  end
end
