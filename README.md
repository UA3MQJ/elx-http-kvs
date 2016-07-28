# Kvs

HTTP key-value storage

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `kvs` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:kvs, "~> 0.1.0"}]
    end
    ```

  2. Ensure `kvs` is started before your application:

    ```elixir
    def application do
      [applications: [:kvs]]
    end
    ```

## Start

    iex -S mix

## Test

    curl -X GET http://localhost:4000/abc -i
    curl -X DELETE http://localhost:4000/abc -i
    curl -X POST --data "123" http://localhost:4000/abc
    curl -X PUT --data "123" http://localhost:4000/abc
