defmodule Kvs.DB_GEN do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def select(server, key) do
    GenServer.call(server, {:select, key})
  end

  def update(server, key, value) do
    GenServer.call(server, {:put, key, value})
  end

  def delete(server, key) do
    GenServer.call(server, {:delete, key})
  end

  def init(:ok) do
    :dets.open_file(:base, [type: :set])
  end

  def terminate(_reason, state) do
    :dets.close(state)
  end

  def handle_call({:select, key}, _from, state) do
    result = :dets.lookup(state, key)
    if result == [] do
	{:reply, :null, state}
    else
	[{_key, value}] = result
        {:reply, value, state}
    end
  end

  def handle_call({:delete, key}, _from, state) do
    response = :dets.delete(state, key)
    {:reply, response, state}
  end

  def handle_call({:put, key, value}, _from, state) do
    response = :dets.insert(state, {key, value})
    {:reply, response, state}
  end

end
