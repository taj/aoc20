defmodule DayOne do
  def part_1, do: read_input() |> do_part_1()

  def part_2, do: read_input() |> do_part_2()

  # Result is 927684
  defp do_part_1(input) do
    matches =
      for a <- input, b <- input do
        if a + b == 2020 do
          a * b
        end
      end

    matches
    |> Enum.reject(&(&1 == nil))
    |> hd()
  end

  # Result is 292093004
  defp do_part_2(input) do
    matches =
      for a <- input, b <- input, c <- input do
        if a + b + c == 2020 do
          a * b * c
        end
      end

    matches
    |> Enum.reject(&(&1 == nil))
    |> hd()
  end

  defp read_input() do
    "lib/inputs/day_one"
    |> File.read!()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.to_integer/1)
  end
end
