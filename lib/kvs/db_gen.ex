defmodule Kvs.DB_GEN do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def select(key) do
    GenServer.call(__MODULE__, {:select, key})
  end

  def update(key, value, ttl) do
    GenServer.call(__MODULE__, {:put, key, value, ttl})
  end

  def delete(key) do
    GenServer.call(__MODULE__, {:delete, key})
  end

  def clean() do
    GenServer.call(__MODULE__, :clean)
  end

  def init(:ok) do
    :dets.open_file(:base, [type: :set])
  end

  def terminate(_reason, state) do
    :dets.close(state)
  end

  def handle_call({:select, key}, _from, state) do
    {:reply, get_value(state, key), state}
  end

  def handle_call({:delete, key}, _from, state) do
    {:reply, :dets.delete(state, key), state}
  end

  def handle_call({:put, key, value, ttl}, _from, state) do
    {:reply, :dets.insert(state, {key, {value, ttl, :erlang.timestamp()}}), state}
  end

  def handle_call(:clean, _from, state) do
    {:reply, clean_base(state), state}
  end


  def get_value(state, key) do
    case :dets.lookup(state, key) do
	[] -> :null
	[{key, {value, ttl, created_time}}] ->
	    real_ttl = :timer.now_diff(:erlang.timestamp(), created_time)
	    case ((real_ttl/1000000) < ttl) do
		true -> value
		_ ->
		    :dets.delete(state, key)
		    :null
	    end
	_ -> :null
    end
  end

  def clean_base(state) do
    key = :dets.first(state)
    clean_base(state, key)
  end

  def clean_base(state, key) do
    case key do
	:'$end_of_table' -> :ok
	_ ->
	    key_next = :dets.next(state, key)
	    get_value(state, key)
	    clean_base(state, key_next)
    end
  end
end
