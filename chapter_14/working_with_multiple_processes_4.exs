defmodule Linker2 do
  import :timer, only: [sleep: 1]

  def notify(sender) do
    send sender, "Hello Kermit!"
    raise RuntimeError, message: "Child raised error"
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
    spawn_link(Linker2, :notify, [self()])
    :timer.sleep(500)
    read_message()
  end
end


ExUnit.start

defmodule Linker2Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run returns proper messages" do
    messages_string = """
    MESSAGE RECIEVED \"Hello Kermit!\"
    MESSAGE RECIEVED {:EXIT, #PID<0.95.0>, {%RuntimeError{message: \"Child raised error\"}, [{Linker2, :notify, 1, [file: 'working_with_multiple_processes_4.exs', line: 6]}]}}
    No more messages in mailbox
    """

    expected = capture_io fn ->
      Linker2.run
    end

    assert expected == messages_string
  end
end
