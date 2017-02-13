# CracowWeather

This application is solution for exercise 6 of chapter 13 written in
`Programming Elixir` by `Dave Thomas`. It allows user to quickly fetch weather
data from Cracow, Poland and print it to terminal.

It is also executable Erlang Escript.

## Installation
You need to have Elixir version `1.4` installed localy.

First download dependencies.
```
mix deps.get
```

Than you can type run to compile
```
mix run
```

## Usage via IEx
Go to root path of this app.

Compile and load CracowWeather to Iex.
```
iex -S mix
```

Print latest weather data to your terminal.
```
CracowWeather.CLI.main
```

## Usage as a shell script via escript
Make sure you have Erlang installed

Build fresh version of script
```
mix escript.build
```

Run script via shell.
```
./cracow_weather
```

## Tests
To run tests simply type
```
mix test
```

## Documentation
To generate documentation via ex_doc please type
```
mix docs
```

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cracow_weather` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:cracow_weather, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cracow_weather](https://hexdocs.pm/cracow_weather).

