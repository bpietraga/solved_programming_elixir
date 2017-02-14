defmodule TwoProcessesSpawner do
  def receive_token(process) do
    receive do
      token ->
        send(process, token)
    end
  end

  def generate_process(token) do
    spawn(TwoProcessesSpawner, :receive_token, [self()])
    |> send(token)

    receive do
      response ->
        IO.inspect(response)
    end
  end

  def run do
    generate_process(:fred)
    generate_process(:betty)
  end
end

ExUnit.start

defmodule TwoProcessesSpawnerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run used 5 times returns :fred" do
    io_string = """
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    """

    result = capture_io fn ->
      Enum.each(1..5, fn(_n) -> TwoProcessesSpawner.run end)
    end

    assert result == io_string
  end


  test "run used 10 times returns :fred" do
    io_string = """
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    :fred
    :betty
    """

    result = capture_io fn ->
      Enum.each(1..10, fn(_n) -> TwoProcessesSpawner.run end)
    end

    assert result == io_string
  end
end
