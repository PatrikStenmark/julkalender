commands =
  File.read!("input.txt")
  |> String.split("\n")
  |> Enum.map(fn line ->
    [command, value] = String.split(line, " ")
    {String.to_atom(command), String.to_integer(value)}
  end)
  |> IO.inspect()

{h, d, _} =
  Enum.reduce(commands, {0, 0, 0}, fn {cmd, arg}, {h, d, aim} ->
    case cmd do
      :forward ->
        {h + arg, d + aim * arg, aim}

      :down ->
        {h, d, aim + arg}

      :up ->
        {h, d, aim - arg}
    end
    |> IO.inspect()
  end)
  |> IO.inspect()

IO.puts("result: #{h * d}")
