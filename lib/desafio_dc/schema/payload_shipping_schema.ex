defmodule DesafioDc.Schema.PayloadShippingSchema do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :id, :integer
    field :shipment_type, :string
    field :date_created, :utc_datetime

    embeds_one :receiver_address, ReceiverAddress, primary_key: {:id, :integer, []} do
      field :address_line, :string
      field :street_name, :string
      field :street_number, :string
      field :comment, :string
      field :zip_code, :string

      embeds_one :city, City do
        field :name, :string
      end

      embeds_one :state, State do
        field :name, :string
      end

      embeds_one :country, Country, primary_key: {:id, :string, []} do
        field :name, :string
      end

      embeds_one :neighborhood, Neighborhood, primary_key: {:id, :string, []} do
        field :name, :string
      end

      field :latitude, :float
      field :longitude, :float
      field :receiver_phone, :string
    end
  end

  defp changeset_with_name_only(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  defp changeset_with_name_id(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:id, :name])
    |> validate_required([:name])
  end

  defp receiver_address_changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [
      :id,
      :latitude,
      :longitude,
      :receiver_phone,
      :address_line,
      :street_name,
      :street_number,
      :comment,
      :zip_code
    ])
    |> cast_embed(:city, with: &changeset_with_name_only/2, required: true)
    |> cast_embed(:state, with: &changeset_with_name_only/2, required: true)
    |> cast_embed(:country, with: &changeset_with_name_id/2, required: true)
    |> cast_embed(:neighborhood, with: &changeset_with_name_id/2, required: true)
  end

  def changeset(changeset, params \\ %{}) do
    changeset
    |> cast(params, [:shipment_type, :date_created])
    |> cast_embed(:receiver_address, with: &receiver_address_changeset/2, required: true)
  end
end
