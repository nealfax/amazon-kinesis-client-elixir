defmodule Kcl.Configuration do
  require Logger

  def properties options do
      default_config
      |> Keyword.merge(options)
      |> check_required
      |> Enum.map(fn {key, value} ->
        "#{make_prop_key(key)}=#{value}"
      end)
      |> Enum.join "\n"
  end

  defp check_required options do
      Enum.each required_property_keys, fn key ->
        if !Keyword.get(options, key) do
          raise "#{key} is required"
        end
      end
      options
  end

  defp default_config do
    Logger.debug inspect processing_language
    Logger.debug inspect executable_name
    [
      executable_name: executable_name,
      application_name: application_name,
      processing_language: processing_language,
      aws_credentials_provider: 'DefaultAWSCredentialsProviderChain',
      initial_position_in_stream: 'TRIM_HORIZON'
    ]
  end

  defp executable_name, do: "elixir"
  defp application_name, do: System.get_env "APP_NAME"
  defp processing_language, do: "elixir/#{System.version}"

  def make_prop_key key do
    Keyword.get(default_key_map, key) || Inflex.camelize(key, :lower)
  end

  def required_property_keys do
    Keyword.keys(default_config)
    |> Enum.concat [:stream_name]
  end


  defp default_key_map do
    [
      aws_credentials_provider: 'AWSCredentialsProvider'
    ]
  end

end
