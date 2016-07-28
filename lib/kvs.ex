defmodule Kvs do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Kvs.Worker.start_link(arg1, arg2, arg3)
      worker(__MODULE__, [], function: :start_web_site),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kvs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def start_web_site do
    {:ok, _} = Plug.Adapters.Cowboy.http(Kvs.Router, [])
  end
end
