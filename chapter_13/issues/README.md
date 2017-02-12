# Issues

Is application from exercises of chapter 13 written in `Programming Elixir` by `Dave Thomas`.
Issues allow user to graphically represent in terminal selected number of
Github issues.

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

Compile and load Issues to Iex.
```
iex -S mix
```

Run help to see options.
```
Issues.CLI.process(:help)
```

Example. Make get request to api asking for `elixir` asking for 4 issues
from elixir-lang user.
```
Issues.CLI.process({"elixir-lang", "elixir", 4})
```

## Usage as a shell script via escript
Make sure you have Erlang installed

Build fresh version of script
```
mix escript.build
```

Run script via shell.
Example. Make get request to api asking for `elixir` asking for 3 issues
from elixir-lang user.
```
./issues elixir-lang elixir 3
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
by adding `issues` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:issues, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/issues](https://hexdocs.pm/issues).

