defmodule SequenceServerTest do
  use ExUnit.Case, async: true

  setup do
    :sys.replace_state(Sequence.Server,
                       fn {_old_state, pid} ->{456, pid} end)
    :ok
  end

  test "the stack has initial values" do
    {stack, pid} = :sys.get_state Sequence.Server
    assert stack == 456
    refute pid == nil
  end

  test "can move the stack to next number" do
    Sequence.Server.next_number
    {next_stack, _pid} = :sys.get_state Sequence.Server
    assert next_stack == 457
  end

  test "can add delta" do
    Sequence.Server.increment_number(3)
    {added_stack, _pid} = :sys.get_state Sequence.Server
    assert added_stack == 459
  end
end
