defmodule LINEDevelopers.LoginAPISpec do
  @callback verify_access_token!(access_token :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback verify_id_token!(id_token :: String.t, client_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback profile!(access_token :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}
end
