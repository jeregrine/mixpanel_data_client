MixpanelDataClient
==================

Client for interacting with the Mixpanel [Data Export API](https://mixpanel.com/docs/api-documentation/data-export-api)

```elixir
query_data = %{"event" => "signed_up", 
               "from_date" => "2011-08-07", 
              "to_date" => "2011-08-09"}
auth_data = {"key", "secret_key"}
MixpanelDataClient.fetch("segmentation", query_data, auth_data)
=> %{"data" => %{...}}
```
