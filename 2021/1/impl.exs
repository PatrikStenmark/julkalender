input =
  File.read!("input.txt")
  |> String.split("\n")
  |> Enum.map(fn i -> String.to_integer(i) end)
  |> IO.inspect()

input
|> Enum.chunk_every(3, 1, :discard)
|> IO.inspect(label: :wip)
|> tap(fn v -> Enum.slice(v, -20, 20) |> IO.inspect() end)
|> Enum.reduce({:inf, 0}, fn [a, b, c], {last_sum, count} ->
  sum = a + b + c
  IO.inspect({last_sum, count, sum, last_sum < sum}, label: :progress)

  if last_sum < sum do
    {sum, count + 1}
  else
    {sum, count}
  end
end)
|> IO.inspect(label: :result)
