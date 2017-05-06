defmodule ReduceEnumerable do
 import(Enum, only: [reduce: 3, reverse: 1])

  def each(collection, function) do
    reduce(collection, 0, fn(x, _accumulator) -> function.(x) end)
  end

  def filter(collection, function) do
    reduce(collection, [], fn(x, accumulator) -> if function.(x),
                                                    do: [x | accumulator],
                                                    else: accumulator
                                                  end)
    |> reverse
  end

  def map(collection, function) do
    reduce(collection, [], fn(x, accumulator) -> [function.(x) | accumulator] end)
    |> reverse
  end
end
