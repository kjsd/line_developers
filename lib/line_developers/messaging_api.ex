defmodule LINEDevelopers.MessagingAPI do
  @behaviour LINEDevelopers.MessagingAPISpec

  alias LineDevelopers.HTTPRequest

  @impl LINEDevelopers.MessagingAPISpec
  def reply!(access_token, reply_token, [m|_] = messages)
  when is_binary(access_token) and is_binary(reply_token) and is_map(m) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
    body = %{"replyToken" => reply_token, "messages" => messages}
    |> Jason.encode!()

    "https://api.line.me/v2/bot/message/reply"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def push!(access_token, to, [m|_] = messages, options \\ [])
  when is_binary(access_token) and is_map(m) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
              |> option_header(options)
    body = %{"to" => to, "messages" => messages}
    |> option_body(options)
    |> Jason.encode!()

    "https://api.line.me/v2/bot/message/push"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def multicast!(access_token, [t|_] = to, [m|_] = messages, options \\ [])
  when is_binary(access_token) and is_binary(t) and is_map(m) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
              |> option_header(options)
    body = %{"to" => to, "messages" => messages}
    |> option_body(options)
    |> Jason.encode!()

    "https://api.line.me/v2/bot/message/multicast"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def broadcast!(access_token, [m|_] = messages, options \\ [])
  when is_binary(access_token) and is_map(m) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
              |> option_header(options)
    body = %{"messages" => messages}
    |> option_body(options)
    |> Jason.encode!()

    "https://api.line.me/v2/bot/message/broadcast"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def narrowcast!(access_token, [m|_] = messages, recipient, filter, limit, options \\ [])
  when is_binary(access_token) and is_map(m) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
              |> option_header(options)

    put_if = fn acc, name, x -> if is_map(x), do: Map.put(acc, name, x), else: acc end

    body = %{"messages" => messages}
    |> put_if.("recipient", recipient)
    |> put_if.("filter", filter)
    |> put_if.("limit", limit)
    |> option_body(options)
    |> Jason.encode!()

    "https://api.line.me/v2/bot/message/narrowcast"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def progress_narrowcast!(access_token, request_id)
  when is_binary(access_token) and is_binary(request_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/message/progress/narrowcast?requestId=#{request_id}"
    |> HTTPRequest.get!(header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def get_audience!(access_token, audience_id)
  when is_binary(access_token) and is_integer(audience_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/audienceGroup/#{audience_id}"
    |> HTTPRequest.get!(header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def create_audience!(access_token, description \\ "tsu-v3-audience", [t|_] = uid)
  when is_binary(access_token) and is_binary(description) and is_binary(t) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]

    lists = Enum.reduce(uid, [], fn x, acc -> [%{"id" => x} | acc] end)

    body = %{"description" => description, "audiences" => lists}
    |> Jason.encode!()

    "https://api.line.me/v2/bot/audienceGroup/upload"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def merge_audience!(access_token, audience_id, [t|_] = uid)
  when is_binary(access_token) and is_integer(audience_id) and is_binary(t) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]

    lists = Enum.reduce(uid, [], fn x, acc -> [%{"id" => x} | acc] end)

    body = %{"audienceGroupId" => audience_id, "audiences" => lists,
             "uploadDescription" => "by TSUNAGARU-V3-MESSENGER"}
    |> Jason.encode!()

    "https://api.line.me/v2/bot/audienceGroup/upload"
    |> HTTPRequest.put!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def delete_audience!(access_token, audience_id)
  when is_binary(access_token) and is_integer(audience_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/audienceGroup/#{audience_id}"
    |> HTTPRequest.delete!(header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def create_richmenu!(access_token, richmenu)
  when is_binary(access_token) and is_map(richmenu) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
    body = richmenu
    |> Jason.encode!()

    "https://api.line.me/v2/bot/richmenu"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def delete_richmenu!(access_token, richmenu_id)
  when is_binary(access_token) and is_binary(richmenu_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/richmenu/#{richmenu_id}"
    |> HTTPRequest.delete!(header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def content_richmenu!(access_token, richmenu_id, file)
  when is_binary(access_token) and is_binary(richmenu_id) and is_binary(file) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "image/png"]

    "https://api-data.line.me/v2/bot/richmenu/#{richmenu_id}/content"
    |> HTTPRequest.post!({:file, file}, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def all_richmenu!(access_token, richmenu_id)
  when is_binary(access_token) and is_binary(richmenu_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/user/all/richmenu/#{richmenu_id}"
    |> HTTPRequest.post!("", header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def link_richmenu!(access_token, richmenu_id, [t|_] = to)
  when is_binary(access_token) and is_binary(richmenu_id) and is_binary(t) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
    body = %{"richMenuId" => richmenu_id, "userIds" => to}
    |> Jason.encode!()

    "https://api.line.me/v2/bot/richmenu/bulk/link"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def unlink_richmenu!(access_token, [t|_] = to)
  when is_binary(access_token) and is_binary(t) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]
    body = %{"userIds" => to}
    |> Jason.encode!()

    "https://api.line.me/v2/bot/richmenu/bulk/unlink"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def alias_richmenu!(access_token, richmenu_id, alias_id)
  when is_binary(access_token) and is_binary(richmenu_id) and is_binary(alias_id) do
    header = ["Authorization": "Bearer #{access_token}",
              "Content-Type": "application/json"]

    body = %{"richMenuAliasId" => alias_id, "richMenuId" => richmenu_id}
    |> Jason.encode!()

    "https://api.line.me/v2/bot/richmenu/alias"
    |> HTTPRequest.post!(body, header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def unalias_richmenu!(access_token, alias_id)
  when is_binary(access_token) and is_binary(alias_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/richmenu/alias/#{alias_id}"
    |> HTTPRequest.delete!(header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def get_richmenu!(access_token, richmenu_id)
  when is_binary(access_token) and is_binary(richmenu_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/richmenu/#{richmenu_id}"
    |> HTTPRequest.get!(header)
    |> parse_response()
  end

  @impl LINEDevelopers.MessagingAPISpec
  def get_profile!(access_token, user_id)
  when is_binary(access_token) and is_binary(user_id) do
    header = ["Authorization": "Bearer #{access_token}"]

    "https://api.line.me/v2/bot/profile/#{user_id}"
    |> HTTPRequest.get!(header)
    |> parse_response()
  end

  defp option_header(header, options) do
    case Keyword.get(options, :retry_key) do
      nil ->
        header
      o ->
        [{:"X-Line-Retry-Key", o} | header]
    end
  end

  defp option_body(body, options) do
    Enum.reduce(options, body, fn x, acc ->
      with {k, v} <- x do
        Map.put(acc, k, v)
      else
        _ ->
          acc
      end
    end)
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
