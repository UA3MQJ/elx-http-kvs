defmodule Kvs.Router do
  use Plug.Router
  use Plug.Debugger

  plug Plug.Logger
  plug :match
  plug :dispatch


  get "/" do
    send_resp(conn, 200, "Hi! Its KVS")
  end

  get "/:key" do
    value = Kvs.DB_GEN.select(Kvs.DB_GEN, key)
    if value==:null do
	send_resp(conn, 404, [])
    else
	send_resp(conn, 200, value)
    end
  end

  delete "/:key" do
    Kvs.DB_GEN.delete(Kvs.DB_GEN, key)
    send_resp(conn, 200, [])
  end

  put "/:key" do
    {:ok, data, _conn} = read_body(conn)
    Kvs.DB_GEN.update(Kvs.DB_GEN, key, data)
    send_resp(conn, 202, [])
  end

  post "/:key" do
    {:ok, data, _conn} = read_body(conn)
    Kvs.DB_GEN.update(Kvs.DB_GEN, key, data)
    send_resp(conn, 202, [])
  end

end
