defmodule DesafioDcWeb.ParserController do
  @moduledoc false
  
  use DesafioDcWeb, :controller

  alias DesafioDc.Parser

  action_fallback DesafioDcWeb.ParserControllerFallback

  def parse(conn, %{"payload" => payload}) do
    with {:ok, json_data} <- Parser.parse(payload) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{data: json_data}))
    end
  end
end
