defmodule LINEDevelopers.HTTPRequest do
  require Logger

  def get(url, header \\ []), do: request(:get, [url, header])
  def post(url, body, header \\ []), do: request(:post, [url, body, header])
  def put(url, body, header \\ []), do: request(:put, [url, body, header])
  def delete(url, header \\ []), do: request(:delete, [url, header])

  def get!(url, header \\ []), do: request!(:get!, [url, header])
  def post!(url, body, header \\ []), do: request!(:post!, [url, body, header])
  def put!(url, body, header \\ []), do: request!(:put!, [url, body, header])
  def delete!(url, header \\ []), do: request!(:delete!, [url, header])

  defp request(method, args) do
    with {:error, reason} <- HTTPoison |> apply(method, args ++ default_args()) do
      "method: #{method}, args: #{inspect(args)}, reason: #{inspect(reason)}"
      |> Logger.error()

      {:error, reason}
    end
  end

  defp request!(method, arg), do: HTTPoison |> apply(method, arg ++ default_args())

  defp default_args(), do: [[recv_timeout: 30000]]


  def get_stream!(url) do
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
