defmodule DayFive do
  # Result is 835
  def part_1 do
    read_input()
    |> Enum.map(&calc_seat_id/1)
    |> Enum.max()
  end

  # Result is 649
  def part_2 do
    read_input()
    |> Enum.map(&calc_seat_id/1)
    |> Enum.sort()
    |> find_missing_no()
  end

  defp find_missing_no([n1, n2 | tail]) do
    if n1 - n2 == -1 do
      find_missing_no([n2 | tail])
    else
      find_middle_no(n1, n2)
    end
  end

  defp find_middle_no(n1, n2) do
    (n1 + n2)
    |> div(2)
    |> floor
  end

  defp calc_seat_id(line) do
    {row, column} = line |> find_seat()
    row * 8 + column
  end

  defp find_seat(boarding_pass, rows \\ 0..127, columns \\ 0..7)

  defp find_seat("F" <> rest, rows, columns) do
    rows = get_lower(rows)
    find_seat(rest, rows, columns)
  end

  defp find_seat("B" <> rest, rows, columns) do
    rows = get_upper(rows)
    find_seat(rest, rows, columns)
  end

  defp find_seat("L" <> rest, rows, columns) do
    columns = get_lower(columns)
    find_seat(rest, rows, columns)
  end

  defp find_seat("R" <> rest, rows, columns) do
    columns = get_upper(columns)
    find_seat(rest, rows, columns)
  end

  defp find_seat("", [row], [column]) do
    {row, column}
  end

  defp get_lower(list) do
    count = floor(Enum.count(list) / 2)
    [list, _] = Enum.chunk_every(list, count)
    list
  end

  defp get_upper(list) do
    count = floor(Enum.count(list) / 2)
    [_, list] = Enum.chunk_every(list, count)
    list
  end

  defp read_input do
    "lib/inputs/day_five"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end
end
