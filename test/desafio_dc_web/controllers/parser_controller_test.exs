defmodule DesafioDcWeb.ParserControllerTest do
  use DesafioDcWeb.ConnCase, async: false

  alias DesafioDcWeb.Support.Data

  test "Processing" do
    json_data = Data.parse_json("payload.json")

    order =
      build_conn()
      |> post("/api/order/parse", %{"payload" => json_data})
      |> json_response(200)
      |> Map.get("data")

    assert order["externalCode"] == 9_987_071

    build_conn()
    |> post("/api/order/parse", %{"payload" => json_data})
    # Duplicated order error. Assert on status code is enough
    |> json_response(400)
  end

  test "Changeset Error" do
    # missing store_id field
    json_data = Data.parse_json("payload_error.json")

    order =
      build_conn()
      |> post("/api/order/parse", %{"payload" => json_data})
      |> json_response(400)

    assert %{"data" => %{"errors" => %{"store_id" => ["can't be blank"]}}} = order

  end
end
