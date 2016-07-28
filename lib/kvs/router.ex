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
    IO.puts("key:")
    IO.puts(key)
    send_resp(conn, 200, "OK")
  end

  delete "/:key" do
    IO.puts("key:")
    IO.puts(key)
    send_resp(conn, 200, [])
  end

  put "/:key" do
    {:ok, data, _conn} = read_body(conn)
    IO.puts("key:")
    IO.puts(key)
    IO.puts("data:")
    IO.puts(data)
    send_resp(conn, 202, [])
  end

  post "/:key" do
    {:ok, data, _conn} = read_body(conn)
    IO.puts("key:")
    IO.puts(key)
    IO.puts("data:")
    IO.puts(data)
    send_resp(conn, 202, [])
  end

end
