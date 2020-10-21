defmodule DesafioDc.Schema.PayloadPaymentSchema do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  @params [
    :id,
    :order_id,
    :payer_id,
    :installments,
    :payment_type,
    :status,
    :transaction_amount,
    :taxes_amount,
    :shipping_cost,
    :total_paid_amount,
    :installment_amount,
    :date_approved,
    :date_created
  ]

  embedded_schema do
    field :id, :integer
    field :order_id, :integer
    field :payer_id, :integer
    field :installments, :integer
    field :payment_type, :string
    field :status, :string
    field :transaction_amount, :float
    field :taxes_amount, :float
    field :shipping_cost, :float
    field :total_paid_amount, :float
    field :installment_amount, :float
    field :date_approved, :utc_datetime
    field :date_created, :utc_datetime
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, @params)
    |> validate_required(@params)
  end
end
