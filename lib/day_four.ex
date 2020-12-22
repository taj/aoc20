defmodule DayFour do
  @required_fields MapSet.new(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

  # Result is 208
  def part_1 do
    read_input()
    |> Enum.reduce(0, fn doc, count ->
      if fields_present?(doc), do: count + 1, else: count
    end)
  end

  # Result is 167
  def part_2 do
    read_input()
    |> Enum.reduce(0, fn doc, count ->
      if fields_present?(doc) && data_valid?(doc) do
        count + 1
      else
        count
      end
    end)
  end

  defp data_valid?(doc) do
    doc
    |> Enum.reduce_while(true, fn doc_field, _ ->
      if valid?(doc_field) do
        {:cont, true}
      else
        {:halt, false}
      end
    end)
  end

  defp valid?({"byr", birth_year}) do
    in_range?(birth_year, 1920, 2002)
  end

  defp valid?({"ecl", eye_color})
       when eye_color in ~w[amb blu brn gry grn hzl oth],
       do: true

  defp valid?({"ecl", _}), do: false

  defp valid?({"eyr", exp_year}) do
    in_range?(exp_year, 2020, 2030)
  end

  defp valid?({"hcl", hair_colour}) do
    Regex.match?(~r/#([a-fA-F0-9]{6})/, hair_colour)
  end

  defp valid?({"hgt", height_with_unit}) do
    height = String.slice(height_with_unit, 0, String.length(height_with_unit) - 2)

    cond do
      String.ends_with?(height_with_unit, "cm") ->
        in_range?(height, 150, 193)

      String.ends_with?(height_with_unit, "in") ->
        in_range?(height, 59, 76)

      true ->
        false
    end
  end

  defp valid?({"iyr", issue_year}) do
    in_range?(issue_year, 2010, 2020)
  end

  defp valid?({"pid", passpord_id}) do
    Regex.match?(~r/^\d{9}$/, passpord_id)
  end

  defp in_range?(number, min, max) do
    number = String.to_integer(number)
    number >= min && number <= max
  end

  defp fields_present?(doc) do
    doc_fields = doc |> Map.keys() |> MapSet.new()

    MapSet.subset?(@required_fields, doc_fields)
  end

  defp read_input do
    "lib/inputs/day_four"
    |> File.read!()
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(fn doc ->
      doc
      |> String.split([" ", "\n"])
      |> Enum.reduce(%{}, fn doc_field, acc ->
        field_name = String.slice(doc_field, 0, 3)

        if field_name == "cid" do
          acc
        else
          Map.put(
            acc,
            field_name,
            String.slice(doc_field, 4, String.length(doc_field))
          )
        end
      end)
    end)
  end
end
