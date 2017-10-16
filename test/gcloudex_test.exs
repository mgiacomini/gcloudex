defmodule GCloudexTest do
  use ExUnit.Case
  doctest GCloudex

  test "get_project_id" do 
    project_id = "dummy_project_id"

    assert project_id == GCloudex.get_project_id
  end
end
