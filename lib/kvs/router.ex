defmodule Kvs.Router do
  use Plug.Router
  use Plug.Debugger

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug :match
  plug :dispatch


  get "/" do
    send_resp(conn, 200, "Hi! Its KVS")
  end

  get "/:key" do
    value = Kvs.DB_GEN.select(key)
    if value==:null do
	send_resp(conn, 404, [])
    else
	send_resp(conn, 200, value)
    end
  end

  delete "/:key" do
    Kvs.DB_GEN.delete(key)
    send_resp(conn, 200, [])
  end

  put "/:key" do
    #Kvs.DB_GEN.update(key, data)

    parse(conn,key)
    send_resp(conn, 202, [])
  end

  post "/:key" do
    # {:ok, data, _conn} = read_body(conn)
    # Kvs.DB_GEN.update(key, data, :inf)
    
    parse(conn,key)
    send_resp(conn, 202, [])
  end

  def parse(conn,key) do
    has_ttl = Map.has_key?( conn.params, "ttl")
    has_value = Map.has_key?( conn.params, "value")
    case (has_ttl and has_value) do
	true ->
	    value = conn.params["value"]
	    ttl_str = conn.params["ttl"]
	    {ttl_int,_} = Integer.parse(ttl_str)
	    Kvs.DB_GEN.update(key, value, ttl_int)
	_ ->
	    [value] = Map.keys(conn.body_params)
	    Kvs.DB_GEN.update(key, value, :inf)
    end
  end

end
