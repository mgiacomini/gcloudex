defmodule Test.Dummy.CloudStorage do 
  use ExUnit.Case
  use GCloudex.CloudStorage.Impl, :cloud_storage

  @endpoint "storage.googleapis.com"
  @project_id GCloudex.get_project_id

  def request_service do
    %{
      verb: :get,
      host: @endpoint,
      body: "",
      headers: 
        [
          {"x-goog-project-id", @project_id},
          {"Authorization", "Bearer Dummy Token"}
        ],
      opts: []
    }
  end

  def request(verb, bucket, headers \\ [], body \\ "") do
    %{
      verb: verb,
      host: bucket <> "." <> @endpoint,
      body: body,
      headers: 
        headers ++ 
        [
          {"Authorization", "Bearer Dummy Token"}
        ],
      opts: []        
    }
  end

  def request_query(verb, bucket, headers \\ [], body \\ "", parameters) do
    %{
      verb: verb,
      host: bucket <> "." <> @endpoint <> "/" <> parameters,
      body: body,
      headers: 
        headers ++ 
        [
          {"Authorization", "Bearer Dummy Token"}
        ],
      opts: []        
    }    
  end
end

defmodule CloudStorageTest do
  use ExUnit.Case, async: true
  alias Test.Dummy.CloudStorage, as: API

  @endpoint "storage.googleapis.com"
  @project_id GCloudex.get_project_id

  #########################
  ### GET Service Tests ###
  #########################

  test "list_buckets" do 
    expected = build_expected(:get, @endpoint, [{"x-goog-project-id", @project_id}], "")

    assert expected == API.list_buckets
  end

  ###########################
  ### DELETE Bucket Tests ###
  ###########################

  test "delete_bucket" do 
    expected = build_expected(:delete, "bucket.#{@endpoint}", [], "")

    assert expected == API.delete_bucket "bucket"
  end

  ########################
  ### Get Bucket Tests ###
  ########################

  test "list_objects" do
    expected = build_expected(:get, "bucket.#{@endpoint}", [], "")

    assert expected == API.list_objects "bucket"
  end

  test "list_objects with query from non-empty list" do 
    expected = build_expected(
      :get,
      "bucket.#{@endpoint}/?key1=abc&key2=def",
      [],
      ""
    )

    assert expected == API.list_objects "bucket", [{"key1", "abc"}, {"key2", "def"}]
  end

  test "list list_objects with query from empty list" do 
    expected = build_expected(
      :get,
      "bucket.#{@endpoint}/?",
      [],
      ""
    )

    assert expected == API.list_objects "bucket", []
  end

  test "get_bucket_acl" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?acl", [], "")

    assert expected == API.get_bucket_acl "bucket"
  end

  test "get_bucket_cors" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?cors", [], "")

    assert expected == API.get_bucket_cors "bucket"    
  end

  test "get_bucket_lifecycle" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?lifecycle", [], "")

    assert expected == API.get_bucket_lifecycle "bucket"        
  end

  test "get_bucket_region" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?location", [], "")

    assert expected == API.get_bucket_region "bucket"        
  end  

  test "get_bucket_logging" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?logging", [], "")

    assert expected == API.get_bucket_logging "bucket"        
  end    

  test "get_bucket_class" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?storageClass", [], "")

    assert expected == API.get_bucket_class "bucket"        
  end      

  test "get_bucket_versioning" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?versioning", [], "")

    assert expected == API.get_bucket_versioning "bucket"        
  end        

  test "get_bucket_website" do 
    expected = build_expected(:get, "bucket.#{@endpoint}/?website", [], "")

    assert expected == API.get_bucket_website "bucket"        
  end          

  ###############
  ### Helpers ###
  ###############

  defp build_expected(verb, host, headers, body, parameters \\ :empty) do
    map = %{
      verb: verb, 
      host: host, 
      headers: 
        headers ++         
        [{"Authorization", "Bearer Dummy Token"}],
      body: body,
      opts: []
    }

    
    if parameters != :empty do 
      Map.put(map, host, host <> "/" <> parameters)
    else
      map
    end
  end
end