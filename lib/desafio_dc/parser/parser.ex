defmodule DesafioDc.Parser do
  @moduledoc """
    Module responsible for parsing the incoming data from the endpoint
    `DesafioDcWeb.ParserController.parse/2`.
  """
  alias DesafioDc.Schema.PayloadSchema
  alias DesafioDc.OrderModel

  @parser_url Application.fetch_env!(:desafio_dc, :parser_url)

  @doc """
    Transform the `DesafioDcWeb.PayloadSchema` into a suitable structure for the parser endpoint.
    Please note that some fields are converted to string with interpolation due to
    documentation.
  """
  defp transform(%PayloadSchema{} = payload) do

    map_itens = fn ->
      Enum.map(payload.order_items, fn item ->
        %{
          externalCode: item.item.id,
          name: item.item.title,
          price: item.full_unit_price,
          quantity: item.quantity,
          total: item.quantity * item.full_unit_price,
          subItems: []
        }
      end)
    end

    map_payments = fn ->
      Enum.map(payload.payments, fn payment ->
        %{
          type: String.upcase(payment.payment_type),
          value: payment.total_paid_amount
        }
      end)
    end

    map_customer = fn -> %{
        externalCode: "#{payload.buyer.id}",
        name: payload.buyer.nickname,
        email: payload.buyer.email,
        contact: "#{payload.buyer.phone.area_code}" <> payload.buyer.phone.number
      }
    end

    Map.new()
    |> Map.put(:externalCode, payload.id)
    |> Map.put(:storeId, payload.store_id)
    |> Map.put(:subTotal, "#{payload.total_amount}")
    |> Map.put(:deliveryFee, "#{payload.total_amount_with_shipping - payload.total_amount - payload.total_shipping}")
    |> Map.put(:total_shipping, "#{payload.total_shipping}")
    |> Map.put(:total, "#{payload.total_amount_with_shipping}")
    |> Map.put(:country, payload.shipping.receiver_address.country.id)
    |> Map.put(:state, payload.shipping.receiver_address.state.name)
    |> Map.put(:city, payload.shipping.receiver_address.city.name)
    |> Map.put(:district, payload.shipping.receiver_address.neighborhood.name)
    |> Map.put(:street, payload.shipping.receiver_address.street_name)
    |> Map.put(:complement, payload.shipping.receiver_address.comment)
    |> Map.put(:latitude, payload.shipping.receiver_address.latitude)
    |> Map.put(:longitude, payload.shipping.receiver_address.longitude)
    |> Map.put(:dtOrderCreate, payload.date_created)
    |> Map.put(:postalCode, payload.shipping.receiver_address.zip_code)
    |> Map.put(:number, payload.shipping.receiver_address.street_number)
    |> Map.put(:customer, map_customer.())
    |> Map.put(:items, map_itens.())
    |> Map.put(:payments, map_payments.())
  end

  @doc """
    Prepare and execute the post request on the endpoint for validation of the
    payload received.
  """
  def post(data) do
    {:ok, datetime} = DateTime.now("Etc/UTC")

    # Date formatted. ex: 09h25 - 20-10-20
    date = NimbleStrftime.format(datetime, "%Hh%M - %d/%m/%y ")

    data = Jason.encode!(data)

    # Required header for the request according to documentation
    header = [
      {"X-Sent", date}
    ]

    case HTTPoison.post(@parser_url, data, header) do
      # No body, just signals OK
      {:ok, %{status_code: 200}} -> :ok
      # Usually parameters errors, comes in the form of a string literal
      # But due to lack of documentation, I just pass the string forward
      # to the client without any formating
      {:ok, %{status_code: 400, body: body}} -> {:error, body}
      # Any other error from httpoison
      {:error, _reason} -> {:error, "Unexpected error"}
    end
  end

  @doc """
  Parse the payload and returns the following steps:
    - Validate the payload through the `DesafioDcWeb.PayloadSchema` changeset.
    - Apply the changes and get a PayloadSchema.
    - Transform the data.
    - Send the data to the parser endpoint.
  """
  def parse(params) do
    with changeset = %{valid?: true} <- PayloadSchema.changeset(%PayloadSchema{}, params),
         payload =  %PayloadSchema{} <- PayloadSchema.apply(changeset),
         json_data <- transform(payload),
         :ok <- post(json_data),
         {:ok, d} <- OrderModel.create(json_data) do
      {:ok, json_data}
    end
  end
end
