defmodule Kvs.DB_SUP do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Kvs.DB_GEN, [Kvs.DB_GEN])
    ]

    supervise(children, strategy: :one_for_one)
  end

end
