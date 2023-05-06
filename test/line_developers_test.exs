defmodule LINEDevelopersTest do
  use ExUnit.Case
  doctest LINEDevelopers

  describe "helpers" do
    setup [:config_env]
    
    test "messaging_api/0" do
      assert LINEDevelopers.MessagingAPIStub == LINEDevelopers.messaging_api
    end

    test "login_api/0" do
      assert LINEDevelopers.LoginAPIStub == LINEDevelopers.login_api
    end

    test "upload_richmenu_image!/3" do
      res = LINEDevelopers.upload_richmenu_image!("http://httpbin.org/status/200",
        "ACCESSTOKEN", "RICHMENUID")

      assert match?({:ok, {200, _, _}}, res)
    end
  end

  defp config_env(x) do
    Application.put_env(:line_developers, :messaging_api, LINEDevelopers.MessagingAPIStub)
    Application.put_env(:line_developers, :login_api, LINEDevelopers.LoginAPIStub)
    x
  end
end
