defmodule LINEDevelopers.MessagingAPITest do
  use ExUnit.Case
  @moduletag :line_developers

  alias LINEDevelopers.MessagingAPI

  @channel_access_token "CHANNELACCESSTOKEN"

  @uid "LINEUID"

  @richmenu %{
    size: %{
      width: 2500,
      height: 1686
    },
    selected: true,
    name: "Nice richmenu",
    chatBarText: "Tap here",
    areas: [
      %{
        bounds: %{
          x: 0,
          y: 0,
          width: 2500,
          height: 1686
        },
        action: %{
          type: "postback",
          data: "action=buy&itemid=123"
        }
      }
    ]
  }
  @richmenu1 %{
    size: %{
      width: 2500,
      height: 1686
    },
    selected: false,
    name: "Nice richmenu1",
    chatBarText: "Tap here1",
    areas: [
      %{
        bounds: %{
          x: 0,
          y: 0,
          width: 2500,
          height: 1686
        },
        action: %{
          type: "postback",
          data: "action=buy&itemid=123"
        }
      }
    ]
  }


  describe "todo" do
  end
end
