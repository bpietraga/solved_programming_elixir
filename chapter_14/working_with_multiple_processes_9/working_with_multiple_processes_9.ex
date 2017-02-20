defmodule CatDirCount do
  def run do
    File.cd!("./")
    IO.puts "START CAT COUNTER"
    Scheduler.schedule(CatDirCount, :count, File.ls!)
    |> Enum.map(fn({file, count}) ->
      :io.format("~-40s\s|~2b~n", [file, count])
    end)
    IO.puts "END CAT COUNTER"
  end

  def count(scheduler, file) do
    send scheduler, {self(), {file, count_words(file)}}
  end

  def count_words(file),
    do: _count_words(Regex.compile("cat"), file)
  defp _count_words({:ok, regex}, file),
    do: Regex.scan(regex, File.read!(file)) |> length
  defp _count_words({:error, _reason}, _file),
    do: 0
end

defmodule Scheduler do
  def schedule(module, function, data) do
    data
    |> Enum.map(fn(x) -> spawn(module, function, [self(), x]) end)
    |> collect_results([])
  end

  def collect_results(processes, results) do
    receive do
      {child, result} when length(processes) > 1 ->
        collect_results(List.delete(processes, child), [result | results])
      {_child, result} ->
        [result | results]
    end
  end
end

ExUnit.start

defmodule CatDirCountTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "run returns list of files with cats" do
    terminal_string = """
      START CAT COUNTER
      working_with_multiple_processes_9.ex     | 5
      cat_3.txt                                | 3
      cat_2.txt                                | 2
      cat_1.txt                                | 1
      END CAT COUNTER
      """
    expected = capture_io fn ->
      CatDirCount.run
    end

    assert expected == terminal_string
  end
end
