MixpanelDataClient
==================

Client for interacting with the Mixpanel [Data Export API](https://mixpanel.com/docs/api-documentation/data-export-api)

```elixir
  MixpanelDataClient.fetch("segmentation", %{"event" => "signed_up", "from_date" => "2011-08-07",
        "to_date" => "2011-08-09"}, {"key", "secret_key"})
  => %{"data" => %{...}}
```
