defmodule DesafioDc.Schema.PayloadOrderSchema do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    embeds_one :item, Item do
      field :title, :string
    end

    field :quantity, :integer
    field :unit_price, :float
    field :full_unit_price, :float
  end

  defp item_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:id, :title])
    |> validate_required([:id, :title])
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:quantity, :unit_price, :full_unit_price])
    |> validate_number(:quantity, greater_than_or_equal_to: 1)
    |> validate_required([:quantity, :unit_price, :full_unit_price])
    |> cast_embed(:item, with: &item_changeset/2, required: true)
  end
end
