defmodule Sequence.Server do
  use GenServer

  def start_link(stack), do:
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)

  def pop, do:
    GenServer.call(__MODULE__, :pop)

  def push(element), do:
    GenServer.cast(__MODULE__, {:push, element})

  def exit, do:
    GenServer.cast(__MODULE__, {:push, :exit})

  def handle_call({:set_stack, stack}, _from, _stack), do:
    {:reply, stack, stack}

  def handle_call(:pop, _from, []), do:
    {:reply, [], []}
  def handle_call(:pop, _from, [head | tail]), do:
    {:reply, head, tail}

  def handle_cast({:push, :exit}, list), do:
    {:stop, :shutdown, list}

  def handle_cast({:push, element}, list), do:
    {:noreply, [element | list]}

  def terminate(reason, status) do
    IO.puts "Server shutdown, reason: #{reason}, current_status: #{status}"
    :ok
  end
end
