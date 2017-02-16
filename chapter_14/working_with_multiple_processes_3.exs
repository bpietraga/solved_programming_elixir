defmodule Linker do
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
    spawn_link(Linker, :notify, [self()])
    :timer.sleep(500)
    read_message()
  end
end


ExUnit.start

defmodule LinkerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run returns proper messages" do
    messages_string = """
    MESSAGE RECIEVED \"Hello Kermit!\"
    MESSAGE RECIEVED {:EXIT, #PID<0.95.0>, :boom}
    No more messages in mailbox
    """

    expected = capture_io fn ->
      Linker.run
    end

    assert expected == messages_string
  end
end
