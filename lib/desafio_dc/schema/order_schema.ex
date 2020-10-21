defmodule DesafioDc.OrderSchema do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :externalCode,
    :storeId,
    :subTotal,
    :deliveryFee,
    :total_shipping,
    :total,
    :country,
    :state,
    :city,
    :district,
    :street,
    :complement,
    :latitude,
    :longitude,
    :dtOrderCreate,
    :postalCode,
    :number
  ]

  schema "orders" do
    field :externalCode, :integer
    field :storeId, :integer
    field :subTotal, :string
    field :deliveryFee, :string
    field :total_shipping, :string
    field :total, :string
    field :country, :string
    field :state, :string
    field :city, :string
    field :district, :string
    field :street, :string
    field :complement, :string
    field :latitude, :float
    field :longitude, :float
    field :dtOrderCreate, :utc_datetime
    field :postalCode, :string
    field :number, :string
    embeds_one :customer, Customer, primary_key: false do
      field :externalCode, :string
      field :name, :string
      field :email, :string
      field :contact, :string
    end
    embeds_many :items, Item, primary_key: false do
      field :externalCode, :string
      field :name, :string
      field :price, :float
      field :quantity, :integer
      field :total, :float
      embeds_many :subItems, SubItem do
        field :name, :string
      end
    end
    embeds_many :payments, Payment do
      field :type, :string
      field :value, :float
    end
  end

  defp customer_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:externalCode, :name, :email, :contact])
    |> validate_required([:externalCode, :name, :email, :contact])
  end

  defp subitem_changeset(changeset, params \\ %{}) do
    cast(changeset, params, [:name])
    # TODO: Implement subitem. lack of documentation for now
  end

  defp payment_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:type, :value])
    |> validate_required([:type, :value])
  end

  defp item_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:externalCode, :name, :price, :quantity, :total])
    |> validate_required([:externalCode, :name, :price, :quantity, :total])
    |> cast_embed(:subItems, with: &subitem_changeset/2)
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:externalCode, name: :externalCode_storeId_index, message: "Ordem duplicada.")
    |> cast_embed(:customer, with: &customer_changeset/2, required: true)
    |> cast_embed(:items, with: &item_changeset/2, required: true)
    |> cast_embed(:payments, with: &payment_changeset/2, required: true)
  end
end
