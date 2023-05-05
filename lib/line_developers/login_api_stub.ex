defmodule LINEDevelopers.LoginAPIStub do
  @behaviour LINEDevelopers.LoginAPISpec

  require Logger

  @impl LINEDevelopers.LoginAPISpec
  def verify_access_token!(x1) when is_binary(x1) do
    log(:verify_access_token!, [x1])

    data = %{
      "scope" => "profile",
      "client_id" => "1440057261",
      "expires_in" => 2591659
    }

    {:ok, {200, data, []}}
  end

  @impl LINEDevelopers.LoginAPISpec
  def verify_id_token!(x1, x2) when is_binary(x1) and is_binary(x2) do
    log(:verify_id_token!, [x1, x2])

    data = %{
      "iss" => "https://access.line.me",
      "sub" => "U1234567890abcdef1234567890abcdef",
      "aud" => "1234567890",
      "exp" => 1504169092,
      "iat" => 1504263657,
      "nonce" => "0987654asdf",
      "amr" => [
        "pwd",
        "linesso",
        "lineqr"
      ],
      "name" => "Taro Line",
      "picture" => "https://sample_line.me/aBcdefg123456",
      "email" => "taro.line@example.com"
    }

    {:ok, {200, data, []}}
  end

  @impl LINEDevelopers.LoginAPISpec
  def profile!(x1) when is_binary(x1) do
    log(:profile!, [x1])

    data = %{
      "userId" => "U4af4980629...",
      "displayName" => "Brown",
      "pictureUrl" => "https://profile.line-scdn.net/abcdefghijklmn",
      "statusMessage" => "Hello, LINE!"
    }

    {:ok, {200, data, []}}
  end

  defp log(x, p) do
    "You now on stub: #{__MODULE__}:#{x}, "
    |> Kernel.<>(inspect(p))
    |> Logger.warning

    {:ok, {200, nil, []}}
  end
end
