defmodule DayEight do
  # Result is 1671
  def part_1 do
    read_input() |> run()
  end

  def part_1(cmds) do
    run(cmds)
  end

  # Result is 892
  def part_2 do
    cmds = read_input()

    0..(length(cmds) - 1)
    |> Enum.reduce_while(nil, fn index, _ ->
      case Enum.at(cmds, index) do
        {"nop", arg, _} ->
          cmds
          |> replace_cmd(index, "jmp", arg)
          |> part_1()
          |> halt_or_continue()

        {"jmp", arg, _} ->
          cmds
          |> replace_cmd(index, "nop", arg)
          |> part_1()
          |> halt_or_continue()

        _ ->
          {:cont, nil}
      end
    end)
  end

  defp run(cmds, acc \\ 0, index \\ 0) do
    if Enum.count(cmds) == index do
      {acc, false}
    else
      cmds
      |> Enum.at(index)
      |> run_cmd(cmds, acc, index)
    end
  end

  defp run_cmd({_, _, true}, _, acc, _), do: {acc, true}

  defp run_cmd({"nop", _, _}, cmds, acc, index) do
    cmds = mark_current_as_run(cmds, index)
    run(cmds, acc, index + 1)
  end

  defp run_cmd({"acc", arg, _}, cmds, acc, index) do
    cmds = mark_current_as_run(cmds, index)
    acc = acc + arg
    run(cmds, acc, index + 1)
  end

  defp run_cmd({"jmp", arg, _}, cmds, acc, index) do
    cmds = mark_current_as_run(cmds, index)
    index = index + arg
    run(cmds, acc, index)
  end

  defp mark_current_as_run(cmds, index) do
    {cmd, arg, _} = Enum.at(cmds, index)
    List.replace_at(cmds, index, {cmd, arg, true})
  end

  defp replace_cmd(cmds, index, to, arg) do
    List.replace_at(cmds, index, {to, arg, false})
  end

  defp halt_or_continue({_, true}), do: {:cont, nil}
  defp halt_or_continue({acc, false}), do: {:halt, acc}

  defp read_input do
    "lib/inputs/day_eight"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn cmd ->
      [cmd, arg] = String.split(cmd, " ")
      {cmd, String.to_integer(arg), false}
    end)
  end
end
