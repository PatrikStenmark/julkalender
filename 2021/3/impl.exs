input =
  File.read!("input.txt")
  |> String.split("\n")
  |> Enum.map(fn line ->
    String.to_integer(line, 2)
  end)
  |> IO.inspect(label: :input)

import Bitwise

initial = [
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0},
  {0, 0}
]

initial
|> Enum.with_index()
|> Enum.map(fn {counts, n} ->
  IO.inspect({Integer.to_string(n, 2), counts}, label: :outer)

  {zeros, ones} =
    Enum.reduce(input, counts, fn value, {zeros, ones} ->
      IO.puts(Integer.to_string(value, 2))

      set? =
        value
        |> band(1 <<< n)
        |> bsr(n) == 1

      if set? do
        {zeros, ones + 1}
      else
        {zeros + 1, ones}
      end
    end)

  if zeros >= ones do
    0
  else
    1
  end
end)
|> IO.inspect(label: :after_reverse)
|> Enum.with_index()
|> Enum.reduce({0, 0}, fn {b, i}, {eps, gamma} ->
  if b == 0 do
    {eps, bor(gamma, bsl(1, i))}
  else
    {bor(eps, bsl(1, i)), gamma}
  end
end)
|> then(fn {eps, gamma} -> eps * gamma end)
|> IO.inspect(label: :result)
