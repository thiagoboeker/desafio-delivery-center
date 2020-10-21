defmodule DesafioDc.OrderModel do
  @moduledoc false
  
  alias DesafioDc.Repo
  alias DesafioDc.OrderSchema

  def create(params) do
    %OrderSchema{}
    |> OrderSchema.changeset(params)
    |> Repo.insert()
  end
end
