defmodule LINEDevelopers do
  alias LINEDevelopers.HTTPRequest
  
  def messaging_api(), do: Application.get_env(:line_developers, :messaging_api)
  def login_api(), do: Application.get_env(:line_developers, :login_api)

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
