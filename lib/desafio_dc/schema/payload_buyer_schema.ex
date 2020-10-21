defmodule DesafioDc.Schema.PayloadBuyerSchema do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :id, :integer
    field :nickname, :string
    field :email, :string

    embeds_one :phone, Phone do
      field :area_code, :integer
      field :number, :string
    end

    field :first_name, :string
    field :last_name, :string

    embeds_one :billing_info, BillingInfo do
      field :doc_type, :string
      field :doc_number, :string
    end
  end

  def billing_info_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:doc_type, :doc_number])
    |> validate_required([:doc_type, :doc_number])
  end

  def phone_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:area_code, :number])
    |> validate_required([:area_code, :number])
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:id, :nickname, :email, :first_name, :last_name])
    |> validate_required([:nickname, :email, :first_name, :last_name])
    |> cast_embed(:billing_info, with: &billing_info_changeset/2, required: true)
    |> cast_embed(:phone, with: &phone_changeset/2, required: true)
  end
end
