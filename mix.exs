defmodule MixpanelDataClient.Mixfile do
  use Mix.Project

  def project do
    [app: :mixpanel_data_client,
     version: "0.0.2",
     elixir: "~> 1.0",
     description: "Client library for interacting with the Mixpanel Data API.",
     package: [
       contributors: ["Jason Stiebs"],
       links: %{ "Github" => "https://github.com/jeregrine/mixpanel_data_client", "Mixpanel Data API" =>"https://mixpanel.com/docs/api-documentation/data-export-api"},
       licenses: ["MIT"]
     ],
     name: "MixpanelDataClient",
     source_url: "https://github.com/jeregrine/mixpanel_data_client",
     homepage_url: "https://github.com/jeregrine/mixpanel_data_client",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.6"},
      {:poison,    "~> 1.3.1"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.7", only: :dev}
    ]
  end
end
