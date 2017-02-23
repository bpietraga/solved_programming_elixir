defmodule Sequence.Server do
  use GenServer

  def handle_call({:set_stack, stack}, _from, _stack), do:
    {:reply, stack, stack}

  def handle_call(:pop, _from, []),
    do: {:reply, [], []}
  def handle_call(:pop, _from, [head | tail]),
    do: {:reply, head, tail}
end
