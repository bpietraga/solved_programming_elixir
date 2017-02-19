defmodule Linker4 do
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
    spawn_monitor(Linker4, :notify, [self()])
    :timer.sleep(500)
    read_message()
  end
end


ExUnit.start

defmodule Linker4Test do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run returns proper messages" do
    {:ok, regex_1} = Regex.compile("MESSAGE RECIEVED \"Hello Kermit!\"")
    {:ok, regex_2} = Regex.compile("MESSAGE RECIEVED {:DOWN, ")
    {:ok, regex_3} = Regex.compile("{%RuntimeError{message: ")
    {:ok, regex_4} = Regex.compile("\"Child raised error\"}, ")
    {:ok, regex_5} = Regex.compile("Linker4, :notify, 1")
    {:ok, regex_6} = Regex.compile("file: 'working_with_multiple_processes_5_b.exs',")

    messages_string = """
    No more messages in mailbox
    """

    expected = capture_io fn ->
      Linker4.run
    end

    assert Regex.match?(regex_1, expected)
    assert Regex.match?(regex_2, expected)
    assert Regex.match?(regex_3, expected)
    assert Regex.match?(regex_4, expected)
    assert Regex.match?(regex_5, expected)
    assert Regex.match?(regex_6, expected)
  end
end
