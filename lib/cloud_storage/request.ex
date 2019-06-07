defmodule GCloudex.CloudStorage.Request do
  @moduledoc """
  Offers HTTP requests to be used in by the Google Cloud Storage wrapper.
  """

  alias Tesla.Env, as: HTTPResponse
  alias GCloudex.Auth, as: Auth

  defmacro __using__(_opts) do
    quote do
      @endpoint "storage.googleapis.com"

      def project do
        GCloudex.get_project_id()
      end

      @doc """
      Sends an HTTP request according to the Service resource in the Google Cloud
      Storage documentation.
      """
      @spec request_service :: HTTPResponse.t()
      def request_service do
        do_request(
          :get,
          @endpoint,
          "",
          [
            {"x-goog-project-id", project()},
            {"Authorization", "Bearer #{Auth.get_token_storage(:full_control)}"}
          ],
          []
        )
      end

      @doc """
      Sends an HTTP request without any query parameters.
      """
      @spec request(atom, binary, list(tuple), binary) :: HTTPResponse.t()
      def request(verb, bucket, headers \\ [], body \\ "") do
        do_request(
          verb,
          bucket <> "." <> @endpoint,
          body,
          headers ++ [{"Authorization", "Bearer #{Auth.get_token_storage(:full_control)}"}],
          []
        )
      end

      @doc """
      Sends an HTTP request with the specified query parameters.
      """
      @spec request_query(atom, binary, list(tuple), binary, binary) :: HTTPResponse.t()
      def request_query(verb, bucket, headers \\ [], body \\ "", parameters) do
        do_request(
          verb,
          bucket <> "." <> @endpoint <> "/" <> parameters,
          body,
          headers ++ [{"Authorization", "Bearer #{Auth.get_token_storage(:full_control)}"}],
          []
        )
      end

      defp do_request(method, url, body \\ "", headers \\ [], options \\ []) do
        Tesla.request(method: method, url: url, body: body, headers: headers, opts: options)
      end

      defoverridable request_service: 0,
                     request: 2,
                     request: 3,
                     request: 4,
                     request_query: 3,
                     request_query: 4,
                     request_query: 5
    end
  end
end
