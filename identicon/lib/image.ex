defmodule Identicon.Image do
  defstruct data: nil, color: nil, grid: nil, pixel_map: nil
end

# Usage
#  %Identicon.Image{}
#  %Identicon.Image{data: []}