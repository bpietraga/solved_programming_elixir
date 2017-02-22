defmodule Ticker do
  @interval 2000
  @name :ticker

  def start(name) do
    pid = spawn(__MODULE__, :generator, [name])
    :global.register_name(@name, pid)
    send(pid, {:tick, name})
  end

  def join(name) do
    pid = spawn(__MODULE__, :generator, [[]])
    send(pid, {:tick, name})
  end

  def host do
    :global.whereis_name(@name)
  end

  def generator(name, client \\ self()) do
    root = host()
    receive do
      {:register, pid} when client == root ->
        generator(name, pid)
      reg = {:register, _pid} ->
        send(client, reg)
      {:tick, pid_name} ->
        IO.inspect "tick from #{inspect(pid_name)}"
        :timer.sleep(@interval)
        send(client, {:tick, name})
    end
    generator(name, client)
  end
end
