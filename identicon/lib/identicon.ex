#
# $ iex -S Mix
# iex> Identicon.main "asdf"
#
defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def pick_color(image_struct) do
    %Identicon.Image{data: [r, g, b | _tail]} = image_struct
    %Identicon.Image{image_struct | color: {r, g, b}}
  end

  def hash_input(input) do
    # :crypto.hash(:md5, "banana") |> Base.encode16
    data = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{data: data}
  end

  def build_grid(%Identicon.Image{data: tomb} = image_struct) do
    grid =
      tomb
      |> Enum.chunk(3)
      # [[145, 46, 200], [3, 178, 206], [73, 228, 165], [65, 6, 141], [73, 90, 181]]

      # & sign only references the mirror_row function, instead of calling it
      |> Enum.map(&mirror_row/1)
      # # [[145, 46, 200, 46, 145], [3, 178, 206, 178, 3], [73, 228, 165, 228, 73], [65, 6, 141, 6, 65], [73, 90, 181, 90, 73]]
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image_struct | grid: grid}
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _] = row
    row ++ [second, first]
    # [145, 46, 200, 46, 145]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image_struct) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end
    %Identicon.Image{image_struct | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image_struct) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      x = rem(index, 5) * 50
      y = div(index, 5) * 50
      top_left = {x, y}
      bottom_right = {x + 50, y + 50}
      {top_left, bottom_right}
    end
    %Identicon.Image{image_struct | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create 250, 250
    fill = :egd.color color

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle image, start, stop, fill
    end

    :egd.render image
  end

  def save_image(image, filename) do
    File.write "#{filename}.png", image
  end
end
