defmodule MixpanelDataClientTest do
  use ExUnit.Case
  import MixpanelDataClient

  #TODO Bleh not great
  test "mixpanel_uri produces correct output" do
    key = "abc123"
    secret = "1234"
    expire = 60
    query_params = %{a: "1", b: "2"}

    signed_params = signature(query_params, key, secret, expire)
    assert mixpanel_uri("endpoint", query_params, key, secret, expire) == "http://mixpanel.com/api/2.0/endpoint/?" <> URI.encode_query(signed_params)
  end

  test "sign_request" do
    key = "abc123"
    secret = "1234"
    expire = 60
    query_params = %{a: "1", b: "2"}
    result_params = Dict.merge(query_params, %{"api_key" => key, "expire" => expire})

    result = result_params
              |> Enum.sort() 
              |> Enum.map_join("", &encode_pair/1)
    result = result <> secret
    signature = md5(result)
    
    assert signature(query_params, key, secret, expire) == Dict.merge(result_params, %{"sig" => signature})
  end

  test "expire" do
    assert expire(10) == 70
    assert expire(10, 10) == 20
    assert expire() != nil
  end
end
