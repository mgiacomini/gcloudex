defmodule GCloudex.Mixfile do
  use Mix.Project

  @version "0.9.0"

  def project do
    [
     app: :gcloudex_storage,
     version: @version,
     elixir: "~> 1.5",
     description: "Google Cloud Storage for Elixir. Friendly set of wrappers for "
                   <> "Google Cloud Storage Platform API's.",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :goth]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.13.0"},
      {:goth,      "~> 0.7.0"},
      {:poison,    "~> 3.1"},
      {:credo,     "~> 0.8.8", only: [:dev, :test]},
      {:ex_doc,    "~> 0.16", only: [:dev]}
    ]
  end

  defp package do
    [
     maintainers: ["Mauricio Giacomini Girardello"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/mgiacomini/gcloudex"}
    ]
  end
end
