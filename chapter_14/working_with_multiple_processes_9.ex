defmodule CatCount do
  def run do
    { _, wd } = File.cwd
    File.cd!("./")
    IO.puts "Start word count"
    Scheduler.schedule(CatCount, :count, File.ls!)
    |> Enum.map(fn({file, count}) ->
      :io.format "~-30s ~10B~n", [file, count]
    end)
    IO.puts "End word count"
    File.cd! wd
  end

  def count(scheduler, file) do
    send scheduler, {self(), {file, count_words(file)}}
  end

  def count_words(file),
    do: _count_words(Regex.compile("cat"), file)
  defp _count_words({:ok, regex}, file),
    do: Regex.scan(regex, File.read!(file)) |> length
  defp _count_words({:error, _reason}, _file),
    do: -1
end

defmodule Scheduler do
  def schedule(module, function, data) do
    data
    |> Enum.map(fn(x) -> spawn(module, function, [self(), x]) end)
    |> collect_results([])
  end

  def collect_results(processes, results) do
    receive do
      { child, result } when length(processes) > 1 ->
        collect_results(List.delete(processes, child), [result | results])
      { _child, result } ->
        [result | results]
    end
  end
end

CatCount.run
