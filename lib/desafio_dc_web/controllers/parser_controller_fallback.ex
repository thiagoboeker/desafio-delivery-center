defmodule DesafioDcWeb.ParserControllerFallback do
  @moduledoc false

  use DesafioDcWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_resp_content_type("application/json")
    |> put_view(DesafioDcWeb.ChangesetView)
    |> put_status(400)
    |> render("error.json", %{changeset: changeset})
  end

  def call(conn, {:error, reason}) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(400, Jason.encode!(%{errors: reason}))
  end

  def call(conn, %Ecto.Changeset{} = changeset) do
    conn
    |> put_resp_content_type("application/json")
    |> put_view(DesafioDcWeb.ChangesetView)
    |> put_status(400)
    |> render("error.json", %{changeset: changeset})
  end
end
