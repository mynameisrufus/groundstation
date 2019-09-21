defmodule GroundStationWeb.CompassLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <svg viewBox="-50 -50 100 100" xmlns="http://www.w3.org/2000/svg">
      <text font-size="5" font-weight="bold" x="0.5" y="-43" text-anchor="middle"><%= 0 #@bearing %>º</text>
      <g transform="rotate(<%= 0 #@bearing %>)">
        <circle r="40" fill="whitesmoke" />
        <circle r="38" fill="none" stroke="#aaa" stroke-width="4" stroke-dasharray="0.25 4.72" stroke-dashoffset="0" />
        <circle r="38" fill="none" stroke="#aaa" stroke-width="4" stroke-dasharray="0.50 14.395" stroke-dashoffset="0" />
        <circle r="37" fill="none" stroke="#666" stroke-width="6" stroke-dasharray="0.75 57.4" stroke-dashoffset="29.3" />
        <circle r="37" fill="none" stroke="#111" stroke-width="6" stroke-dasharray="1.00 57.15" stroke-dashoffset="0.4" />
        <g id="cardinal" font-size="5" font-weight="bold" text-anchor="middle" fill="#333">
          <text x="0" y="-29" transform="rotate(0)">N</text>
          <text x="0" y="-29" transform="rotate(90)">E</text>
          <text x="0" y="-29" transform="rotate(180)">S</text>
          <text x="0" y="-29" transform="rotate(270)">W</text>
        </g>
        <g id="primary-intercardinal" font-size="5" font-weight="normal" text-anchor="middle" fill="#333">
          <text x="0" y="-29" transform="rotate(45)">NE</text>
          <text x="0" y="-29" transform="rotate(135)">SE</text>
          <text x="0" y="-29" transform="rotate(225)">SW</text>
          <text x="0" y="-29" transform="rotate(315)">NW</text>
        </g>
      </g>
      <g>
        <circle r="1.5" fill="none" stroke="red" stroke-width="0.5" />
        <circle r="1" fill="#333" />
        <line x1="0" y1="-1.5" x2="0" y2="-40" fill="none" stroke="red" stroke-width="0.5" stroke-linecap="round" />
      </g>
    </svg>
    """
  end

  def mount(session, socket) do
    # if connected?(socket), do: nil
    # IO.inspect({:compass, session, socket})

    # {:ok, assign(socket, bearing: session.bearing)}
    {:ok, socket}
  end
end
