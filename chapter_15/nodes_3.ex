defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering: #{IO.inspect(pid)}"
        generator([pid | clients])
    after
      @interval ->
        case clients do
          [] ->
            generator(clients)

          [client | rest_of_clients] ->
            IO.puts "tick to: #{IO.inspect(clients)}"
            send client, {:tick}
            generator(:lists.append(rest_of_clients, [client]))
        end
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
