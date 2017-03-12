defmodule Sequence.Server do
  use GenServer

  @vsn "0"

  # API
  def start_link(stash_pid), do:
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)

  def next_number, do:
    GenServer.call __MODULE__, :next_number

  def increment_number(delta), do:
    GenServer.cast __MODULE__, {:increment_number, delta}

  # GenServer implementation
  def init(stash_pid) do
    current_number = Sequence.Stash.get_value stash_pid
    {:ok, {current_number, stash_pid}}
  end

  def handle_call(:next_number, _from, {current_number, stash_pid}), do:
    {:reply, current_number, {current_number+1, stash_pid}}
  def handle_cast({:increment_number, delta}, {current_number, stash_pid}), do:
    {:noreply, {current_number+delta, stash_pid}}

  def terminate(_reason, {current_number, stash_pid}), do:
    Sequence.Stash.save_value(stash_pid, current_number)
end
