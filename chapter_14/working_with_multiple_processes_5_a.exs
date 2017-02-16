defmodule Linker3 do
  import :timer, only: [sleep: 1]

  def notify(sender) do
    send sender, "Hello Kermit!"
    exit(:boom)
  end

  def read_message do
    receive do
      msg ->
        IO.puts "MESSAGE RECIEVED #{inspect msg}"
        read_message()
    after 0 ->
        IO.puts "No more messages in mailbox"
    end
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_monitor(Linker3, :notify, [self()])
    :timer.sleep(500)
    read_message()
  end
end


ExUnit.start

defmodule Linker3Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run returns proper messages" do
    # Use regex as dynamicaly reference changes
    {:ok, regex_1} = Regex.compile("MESSAGE RECIEVED \"Hello Kermit!\"")
    {:ok, regex_2} = Regex.compile("MESSAGE RECIEVED {:DOWN, ")
    {:ok, regex_3} = Regex.compile("No more messages in mailbox")

    expected = capture_io fn ->
      Linker3.run
    end

    assert Regex.match?(regex_1, expected)
    assert Regex.match?(regex_2, expected)
    assert Regex.match?(regex_3, expected)
  end
end
