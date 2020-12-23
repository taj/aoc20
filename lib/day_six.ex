defmodule DaySix do
  # Result is 6930
  def part_1 do
    read_input()
    |> Enum.map(fn group ->
      group
      |> String.split("\n")
      |> Enum.flat_map(&String.graphemes/1)
      |> MapSet.new()
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  # Result is 3585
  def part_2 do
    read_input()
    |> Enum.map(fn group ->
      group
      |> String.split("\n")
      |> Enum.map(fn answer ->
        answer |> String.graphemes() |> MapSet.new()
      end)
      |> Enum.reduce(fn answer, acc ->
        if acc do
          MapSet.intersection(acc, answer)
        else
          answer
        end
      end)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  defp read_input do
    "lib/inputs/day_six"
    |> File.read!()
    |> String.trim()
    |> String.split("\n\n")
  end
end
