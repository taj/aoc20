defmodule DayNine do
  # Result is 21806024
  def part_1 do
    read_input()
    |> find_invalid()
  end

  # Result is 2986195
  def part_2 do
    input = read_input()
    invalid_no = find_invalid(input)

    numbers = find_sum_numbers(input, invalid_no)
    min = Enum.min(numbers)
    max = Enum.max(numbers)
    min + max
  end

  defp find_invalid(numbers, preamble \\ 25) do
    from = Enum.take(numbers, preamble)
    n = Enum.at(numbers, preamble)

    if is_sum?(from, n) do
      [_ | rest] = numbers
      find_invalid(rest)
    else
      n
    end
  end

  defp is_sum?(from, number) do
    for i <- from, j <- from, uniq: true do
      if i != j && i + j == number do
        true
      else
        false
      end
    end
    |> Enum.member?(true)
  end

  def find_sum_numbers(input, invalid_no, possible_numbers_count \\ 2) do
    possible_numbers = Enum.take(input, possible_numbers_count)

    case Enum.sum(possible_numbers) do
      sum when sum == invalid_no ->
        possible_numbers

      sum when sum > invalid_no ->
        [_ | rest] = input
        find_sum_numbers(rest, invalid_no)

      _ ->
        find_sum_numbers(input, invalid_no, possible_numbers_count + 1)
    end
  end

  defp read_input do
    "lib/inputs/day_nine"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
