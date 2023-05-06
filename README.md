# LINEDevelopers

This package is the LINE API SDK for elixir.
https://developers.line.biz/

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `line_developers` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:line_developers, "~> 0.1.0"}
  ]
end
```

## Configure

Set key `:messaging_api` and `:login_api` to use module.

### by using stub

```elixir
config :line_developers,
  messaging_api: LINEDevelopers.MessagingAPIStub,
  login_api: LINEDevelopers.LoginAPIStub
```
### by using real LINE API

```elixir
config :line_developers,
  messaging_api: LINEDevelopers.MessagingAPI,
  login_api: LINEDevelopers.LoginAPI
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/line_developers>.

