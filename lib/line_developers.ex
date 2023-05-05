defmodule LineDevelopers do
  def messaging_api(), do: Application.get_env(:line_developers, :messaging_api)
  def login_api(), do: Application.get_env(:line_developers, :login_api)

  def upload_richmenu_image!(url, access_token, richmenu_id) do
    file = "/tmp/" <> UUID.uuid4()

    http_stream!(url)
    |> Stream.into(File.stream!(file))
    |> Stream.run()

    try do
      messaging_api()
      |> apply(:content_richmenu!, [access_token, richmenu_id, file])
    after
      File.rm(file)
    end
  end

  defp http_stream!(url) do
    Stream.resource(
      fn -> HTTPoison.get!(url, %{}, [stream_to: self(), async: :once,
                                      recv_timeout: 60000]) end,

      fn %HTTPoison.AsyncResponse{id: id} = resp ->
        receive do
          %HTTPoison.AsyncStatus{id: ^id, code: _} ->
            HTTPoison.stream_next(resp)
            {[], resp}
          %HTTPoison.AsyncHeaders{id: ^id, headers: _} ->
            HTTPoison.stream_next(resp)
            {[], resp}
          %HTTPoison.AsyncChunk{id: ^id, chunk: chunk} ->
            HTTPoison.stream_next(resp)
            {[chunk], resp}
          %HTTPoison.AsyncEnd{id: ^id} ->
            {:halt, resp}
        end
      end,

      fn %HTTPoison.AsyncResponse{id: id} ->
        :hackney.stop_async(id)
      end
    )
  end
end
