defmodule DesafioDcWeb.Support.Data do
  @moduledoc false
  
  def parse_json(file) do
    {:ok, json_string} = File.read(File.cwd!() <> "/test/support/data/#{file}")
    Jason.decode!(json_string)
  end
end
