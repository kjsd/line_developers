defmodule LINEDevelopers.LoginAPI do
  @behaviour LINEDevelopers.LoginAPISpec

  alias LINEDevelopers.HTTPRequest

  @doc """
  https://developers.line.biz/en/reference/line-login/#verify-access-token
  """
  @impl LINEDevelopers.LoginAPISpec
  def verify_access_token!(access_token) when is_binary(access_token) do
    query = %{access_token: access_token}
    |> URI.encode_query()

    "https://api.line.me/oauth2/v2.1/verify"
    |> Kernel.<>("?" <> query)
    |> HTTPRequest.get!()
    |> parse_response()
  end

  @doc """
  https://developers.line.biz/en/reference/line-login/#verify-id-token
  """
  @impl LINEDevelopers.LoginAPISpec
  def verify_id_token!(id_token, client_id)
  when is_binary(id_token) and is_binary(client_id) do

    header = ["Content-Type": "application/x-www-form-urlencoded"]
    body = {:form, [id_token: id_token, client_id: client_id]}

    "https://api.line.me/oauth2/v2.1/verify"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @doc """
  https://developers.line.biz/en/reference/line-login/#get-user-profile
  """
  @impl LINEDevelopers.LoginAPISpec
  def profile!(access_token) when is_binary(access_token) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/profile"
    |> HTTPRequest.get!(header)
    |> parse_response()
  end

  defp parse_response(%HTTPoison.Response{status_code: status, body: body,
                                          headers: headers}) do
    {_, res} = Jason.decode(body)

    case status do
      x when x >= 200 and x < 400 ->
        {:ok, {status, res, headers}}

      _ ->
        {:error, {status, res, headers}}
    end
  end
end
