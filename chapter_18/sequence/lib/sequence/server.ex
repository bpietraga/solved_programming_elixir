defmodule Sequence.Server do
  require Logger
  use GenServer

  @vsn "1"
  defmodule State do
    defstruct current_number: 0, stash_pid: nil, delta: 1
  end

  def code_change(_, state, _extra), do:
    {:ok, state}

  # API
  def start_link(stash_pid), do:
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)

  def next_number do
    with number = GenServer.call(__MODULE__, :next_number), do:
      "The next number is #{number}"
  end

  def increment_number(delta), do:
    GenServer.cast __MODULE__, {:increment_number, delta}

  # GenServer implementation
  def init(stash_pid) do
    {current_number, delta} = Sequence.Stash.get_value(stash_pid)
    {:ok,
     %State{current_number: current_number,
            delta: delta,
            stash_pid: stash_pid}}
  end

  def handle_call(:next_number, _from, state) do
    {:reply,
     state.current_number,
     %{state | current_number: state.current_number + state.delta}}
  end

  def handle_cast({:increment_number, delta}, state) do
    {:noreply,
     %{state | current_number: state.current_number + delta, delta: delta}}
  end

  def terminate(_reason, state) do
    Sequence.Stash.save_value(state.stash_pid,
                              {state.current_number, state.delta})
  end
end
