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

