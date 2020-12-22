defmodule DayThree do
  # Result is 223
  def part_1 do
    input = read_input()
    width = input |> Enum.at(0) |> length()
    height = length(input)

    count_trees(input, {width, height}, {0, 0}, {3, 1})
  end

  # Result is 3517401300
  def part_2 do
    input = read_input()
    width = input |> Enum.at(0) |> length()
    height = length(input)

    count_trees(input, {width, height}, {0, 0}, {1, 1}) *
      count_trees(input, {width, height}, {0, 0}, {3, 1}) *
      count_trees(input, {width, height}, {0, 0}, {5, 1}) *
      count_trees(input, {width, height}, {0, 0}, {7, 1}) *
      count_trees(input, {width, height}, {0, 0}, {1, 2})
  end

  defp count_trees(input, matrix_dims, position, slope, count \\ 0)

  defp count_trees(_, {_, height}, {_, y}, _, count) when y > height - 1, do: count

  defp count_trees(input, {width, height}, {x, y}, {right, bottom}, count) do
    tree? =
      input
      |> Enum.at(y)
      |> Enum.at(x)

    new_y = y + bottom
    new_x = rem(x + right, width)

    count = if tree?, do: count + 1, else: count

    count_trees(input, {width, height}, {new_x, new_y}, {right, bottom}, count)
  end

  def read_input do
    "lib/inputs/day_three"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line |> String.split("") |> Enum.reject(&(&1 == "")) |> Enum.map(&(&1 == "#"))
    end)
  end
end
