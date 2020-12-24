defmodule DaySeven do
  # Result is 185
  def part_1 do
    read_input()
    |> find_containers("shiny gold")
    |> Enum.count()
  end

  # Result is 89084
  def part_2 do
    read_input()
    |> parse_bags()
    |> count_bags("shiny gold")
    |> Kernel.-(1)
  end

  defp find_containers(rules, bag_colour) do
    containers =
      Enum.filter(rules, fn rule ->
        rule =~ " #{bag_colour}"
      end)

    parent_containers =
      Enum.flat_map(containers, fn rule ->
        [bag_colour, _] = String.split(rule, "bags contain")

        find_containers(rules, bag_colour)
      end)

    MapSet.new(containers ++ parent_containers)
  end

  defp parse_bags(rules) do
    rules
    |> Enum.map(fn rule ->
      [colour, bags] = String.split(rule, " bags contain ")

      contained_bags =
        bags
        |> String.trim_trailing(".")
        |> String.split(", ")
        |> Enum.map(&transform/1)

      {colour, contained_bags}
    end)
    |> Enum.into(%{})
  end

  defp transform("no other bags"), do: nil

  defp transform(bag) do
    [no, colour] =
      bag
      |> String.trim_trailing(" bag")
      |> String.trim_trailing(" bags")
      |> String.split(" ", parts: 2)

    {String.to_integer(no), colour}
  end

  defp count_bags(bags, colour) do
    bags[colour]
    |> Enum.reduce(1, fn bag, sum ->
      if bag do
        {no, colour} = bag
        sum + no * count_bags(bags, colour)
      else
        1
      end
    end)
  end

  defp read_input do
    "lib/inputs/day_seven"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end
end
