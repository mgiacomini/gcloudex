defmodule GCloudex.Mixfile do
  use Mix.Project

  @version "1.0.2"

  def project do
    [
      app: :gcloudex_storage,
      version: @version,
      elixir: "~> 1.5",
      description:
        "Google Cloud Storage for Elixir. Friendly set of wrappers for " <>
          "Google Cloud Storage Platform API's.",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [applications: [:logger, :tesla, :goth]]
  end

  defp deps do
    [
      {:tesla, "~> 1.3"},
      {:goth, "~> 1.0"},
      {:jason, "~> 1.1"},
      {:credo, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.20", only: [:dev]}
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
