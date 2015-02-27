defmodule MixpanelDataClient do
  use HTTPoison.Base
  @base_url "http://mixpanel.com/api/2.0/"

  @doc """
    Fetch data from the mixpanel data api.

    Pass in an method, your query paramters, and then your key and secret and it will fetch the data returning a map.

      * Method: As defined [here](https://mixpanel.com/docs/api-documentation/data-export-api#)
        For example, if you wanted to use the segmentation method you'd pass in "segementation". 
        If you wanted to use the annotations create method you'd use "annotations/create"
      * Params: Following the spec, pass a map of query paramters you'd like to use.
      * Auth Tuple: `{key, secret}` using a tuple pass in the key and screet as found in the account settings.
    Example
    ```elixir
      MixpanelDataClient.fetch("segmentation", %{"event" => "signed_up", "from_date" => "2011-08-07",
            "to_date" => "2011-08-09"}, {"key", "secret_key"})
      => %{"data" => %{...}}
    ```
  """
  @spec fetch(String.t, map(), {String.t, String.t}) :: {:error, map()} | {:ok, map()}
  def fetch(endpoint, params, {key, secret}) do
    HTTPoison.get(mixpanel_uri(endpoint, params, key, secret, expire()))
    |> handle_response
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    { :ok, Poison.decode!(body) }
  end
  defp handle_response({:ok, %HTTPoison.Response{body: body}}) do
    { :error, Poison.decode!(body) }
  end

  @nodoc
  def mixpanel_uri(endpoint, query, key, secret, expire) do
    signed_params = signature(query, key, secret, expire)
    @base_url <> endpoint <> "/?" <> URI.encode_query(signed_params)
  end

  @nodoc
  def signature(query_params, key, secret, expire) do
    params = Dict.merge(query_params, %{"api_key" => key, "expire" => expire})
    result = params
      |> Enum.sort() 
      |> URI.encode_query() 
    result = result <> secret
    Dict.merge(params, %{"sig" => :erlang.md5(result)})
  end

  @nodoc
  def expire(base \\ epoch(), future \\ 60), do: base + future
  defp epoch() do
     :calendar.datetime_to_gregorian_seconds(:calendar.now_to_universal_time( :erlang.now()))-719528*24*3600
  end
end
