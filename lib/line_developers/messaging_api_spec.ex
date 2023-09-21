defmodule LINEDevelopers.MessagingAPISpec do
  @callback reply!(access_token :: String.t, reply_token :: String.t,
    messages :: [map()]) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback push!(access_token :: String.t, to :: String.t, messages :: [map()],
    options) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}
  when options: [retry_key: Ecto.UUID.t, notification_disabled: boolean()]

  @callback multicast!(access_token :: String.t, to :: [String.t], messages :: [map()],
    options) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}
  when options: [retry_key: Ecto.UUID.t, notification_disabled: boolean()]

  @callback broadcast!(access_token :: String.t, messages :: [map()], options) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}
  when options: [retry_key: Ecto.UUID.t, notification_disabled: boolean()]

  @callback narrowcast!(access_token :: String.t, messages :: [map()],
    recipient :: map(), filter :: map(), limit :: map(), options) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}
  when options: [retry_key: Ecto.UUID.t, notification_disabled: boolean()]

  @callback progress_narrowcast!(access_token :: String.t, request_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback get_audience!(access_token :: String.t, audience_id :: integer) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback create_audience!(access_token :: String.t, description :: String.t,
    uid :: [String.t]) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback merge_audience!(access_token :: String.t, audience_id :: integer,
    description :: String.t, uid :: [String.t]) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback delete_audience!(access_token :: String.t, audience_id :: integer) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback create_richmenu!(access_token :: String.t, richmenu :: map()) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback delete_richmenu!(access_token :: String.t, richmenu_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback content_richmenu!(access_token :: String.t, richmenu_id :: String.t,
    file :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback all_richmenu!(access_token :: String.t, richmenu_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback link_richmenu!(access_token :: String.t, richmenu_id :: String.t,
    to :: [String.t]) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback unlink_richmenu!(access_token :: String.t, to :: [String.t]) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback alias_richmenu!(access_token :: String.t, richmenu_id :: String.t,
    alias_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback unalias_richmenu!(access_token :: String.t, alias_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback get_richmenu!(access_token :: String.t, richmenu_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback list_richmenu!(access_token :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback list_richmenu_alias!(access_token :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback get_profile!(access_token :: String.t, user_id :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback get_quota!(access_token :: String.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback get_delivery!(access_token :: String.t, date :: Date.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}

  @callback get_statistics_per_unit!(access_token :: String.t, unit_id :: String.t,
    from :: Date.t, to :: Date.t) ::
  {:ok, {status :: integer, body :: map(), headers :: list()}} |
  {:error, {status :: integer, body :: map(), headers :: list()}}
end
