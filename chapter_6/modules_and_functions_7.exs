# 7.1 Use Erlang to format float to be number with 2 decimal points string

defmodule ToString do
  def float(number) do
    :io_lib.format('~.2f', [number]) |> :lists.flatten
  end
end

IO.puts ToString.float(0.123456789)

# 7.2 Elixir get system environment variables

defmodule SystemEnv do
  def get do
    IO.puts System.monotonic_time()
    IO.puts System.get_env("HOME")
    IO.puts System.get_env("SHELL")
  end
end

SystemEnv.get

# 7.3 Get filename extension

defmodule FileExtension do
  def get(path) do
    IO.puts Path.extname(path)
  end
end

FileExtension.get("./modules_and_functions_1.exs")

# 7.4 Get system working directory

IO.puts "System working directory: #{System.cwd}"

# 7.5 Execute system command in script

System.cmd("whoami", [])

