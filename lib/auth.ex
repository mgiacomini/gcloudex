defmodule GCloudex.Auth do
  alias Goth.Token, as: Token

  @moduledoc """
  Provides retrieval of authentication tokens for several Google Cloud Platform
  services' scopes.
  """

  # General Cloud Platform Scopes
  @cloud_scope_cs_read_only   "https://www.googleapis.com/auth/cloud-platform.read-only"
  @cloud_scope_cs             "https://www.googleapis.com/auth/cloud-platform"

  # Cloud Storage scopes
  @storage_scope_read_only    "https://www.googleapis.com/auth/devstorage.read_only"
  @storage_scope_read_write   "https://www.googleapis.com/auth/devstorage.read_write"
  @storage_scope_full_control "https://www.googleapis.com/auth/devstorage.full_control"

  @doc """
  Retrieves an authentication token for the Google Cloud Storage service.
  """
  @spec get_token_storage(atom) :: binary
  def get_token_storage(type)

  def get_token_storage(:read_only) do
    {:ok, token_response} = Token.for_scope @storage_scope_read_only
    Map.get(token_response, :token)
  end

  def get_token_storage(:read_write) do
    {:ok, token_response} = Token.for_scope @storage_scope_read_write
    Map.get(token_response, :token)
  end

  def get_token_storage(:full_control) do
    {:ok, token_response} = Token.for_scope @storage_scope_full_control
    Map.get(token_response, :token)
  end

  def get_token_storage(:cs_read_only) do
    {:ok, token_response} = Token.for_scope @cloud_scope_cs_read_only
    Map.get(token_response, :token)
  end

  def get_token_storage(:cs) do
    {:ok, token_response} = Token.for_scope @cloud_scope_cs
    Map.get(token_response, :token)
  end

  def get_token_storage(_type) do
    raise "Invalid token type"
  end
end
