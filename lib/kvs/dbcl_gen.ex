defmodule Kvs.DBCL_GEN do
  use GenServer
  
  @clean_int 60000 # one minute

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    :erlang.send_after(@clean_int, __MODULE__, :trigger)
    {:ok, []}
  end

  def handle_info(:trigger, state) do
    Kvs.DB_GEN.clean()
    :erlang.send_after(@clean_int, self(), :trigger)
    {:noreply, state}
  end
end
