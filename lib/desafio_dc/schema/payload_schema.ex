defmodule DesafioDc.Schema.PayloadSchema do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  alias DesafioDc.Schema.PayloadOrderSchema
  alias DesafioDc.Schema.PayloadPaymentSchema
  alias DesafioDc.Schema.PayloadShippingSchema
  alias DesafioDc.Schema.PayloadBuyerSchema

  @primary_key false

  @fields [
    :id,
    :store_id,
    :date_closed,
    :date_created,
    :last_updated,
    :total_amount,
    :total_shipping,
    :total_amount_with_shipping,
    :paid_amount,
    :expiration_date,
    :total_shipping,
    :status
  ]

  embedded_schema do
    field :id, :integer
    field :store_id, :integer
    field :date_created, :utc_datetime
    field :date_closed, :utc_datetime
    field :last_updated, :utc_datetime
    field :total_amount, :float
    field :total_shipping, :float
    field :total_amount_with_shipping, :float
    field :paid_amount, :float
    field :expiration_date, :utc_datetime
    field :status, :string
    embeds_many :order_items, PayloadOrderSchema
    embeds_many :payments, PayloadPaymentSchema
    embeds_one :shipping, PayloadShippingSchema
    embeds_one :buyer, PayloadBuyerSchema
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> cast_embed(:order_items)
    |> cast_embed(:payments)
    |> cast_embed(:shipping)
    |> cast_embed(:buyer)
  end

  def apply(%{valid?: true} = changeset) do
    apply_changes(changeset)
  end
end
