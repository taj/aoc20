defmodule DayTwo do
  # Result is 620
  def part_1 do
    read_input()
    |> Enum.reduce(0, fn line, count ->
      valid? =
        line
        |> extract_values()
        |> valid_p1?

      if valid? do
        count + 1
      else
        count
      end
    end)
  end

  # Result is 727
  def part_2 do
    read_input()
    |> Enum.reduce(0, fn line, count ->
      valid? =
        line
        |> extract_values()
        |> valid_p2?

      if valid? do
        count + 1
      else
        count
      end
    end)
  end

  defp valid_p1?({min, max, letter, password}) do
    occurences =
      password
      |> String.graphemes()
      |> Enum.count(&(&1 == letter))

    occurences >= min && occurences <= max
  end

  defp valid_p2?({position1, position2, letter, password}) do
    at_pos1? = String.at(password, position1 - 1) == letter
    at_pos2? = String.at(password, position2 - 1) == letter

    :erlang.xor(at_pos1?, at_pos2?)
  end

  defp extract_values(line) do
    [minmax, letter, password] = String.split(line, " ")
    [min, max] = minmax |> String.split("-") |> Enum.map(&String.to_integer/1)

    letter = String.at(letter, 0)

    {min, max, letter, password}
  end

  defp read_input do
    "lib/inputs/day_two"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end
end
