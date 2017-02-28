defmodule SequenceServerTest do
  use ExUnit.Case, async: true
  doctest Sequence

  test "pop removes first element (not like normal pop)" do
    {:ok, pid} = GenServer.start_link(Sequence.Server, [5, "cat", 9])
    expected = GenServer.call(pid, :pop)
    second_expected = GenServer.call(pid, :pop)
    third_expected = GenServer.call(pid, :pop)
    fourth_expected = GenServer.call(pid, :pop)

    assert expected        == 5
    assert second_expected == "cat"
    assert third_expected  == 9
    assert fourth_expected == []
  end


  test "push add element to array" do
    {:ok, pid} = GenServer.start_link(Sequence.Server, [1, 2, 3])
    GenServer.cast(pid, {:push, "mayoness"})
    expected = GenServer.call(pid, :pop)

    assert expected == "mayoness"
  end

  test "set_stack does its job" do
    {:ok, pid} = GenServer.start_link(Sequence.Server, [1, 2, 3])
    expected = GenServer.call(pid, {:set_stack, ["a", "b", "c"]})
    assert expected == ["a", "b", "c"]
  end
end
