defmodule LINEDevelopers do
  @moduledoc """
  Helpers
  """

  alias LINEDevelopers.HTTPRequest
  
  @doc """
  Get Messaging API module
  """
  def messaging_api(), do: Application.get_env(:line_developers, :messaging_api,
      LINEDevelopers.MessagingAPI)

  @doc """
  Get Login API module
  """
  def login_api(), do: Application.get_env(:line_developers, :login_api,
      LINEDevelopers.LoginAPI)

  @doc """
  Upload richmenu image from URL

  ## Parameters

  - url: specify image downloadable URL
  - access_token: channel access token of Messaging API
  - richmenu_id: LINE Richmenu ID

  """
  def upload_richmenu_image!(url, access_token, richmenu_id) do
    file = "/tmp/" <> UUID.uuid4()

    HTTPRequest.get_stream!(url)
    |> Stream.into(File.stream!(file))
    |> Stream.run()

    try do
      messaging_api()
      |> apply(:content_richmenu!, [access_token, richmenu_id, file])
    after
      File.rm(file)
    end
  end
end
