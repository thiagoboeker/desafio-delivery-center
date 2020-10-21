defmodule DesafioDc.Repo.Migrations.Orders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :externalCode, :integer
      add :storeId, :integer
      add :subTotal, :string
      add :deliveryFee, :string
      add :total_shipping, :string
      add :total, :string
      add :country, :string
      add :state, :string
      add :city, :string
      add :district, :string
      add :street, :string
      add :complement, :string
      add :latitude, :float
      add :longitude, :float
      add :dtOrderCreate, :utc_datetime
      add :postalCode, :string
      add :number, :string
      add :customer, :jsonb
      add :items, :jsonb
      add :payments, :jsonb
    end

    create unique_index(:orders, [:externalCode, :storeId], name: :externalCode_storeId_index)
  end
end
