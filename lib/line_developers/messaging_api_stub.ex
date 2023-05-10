defmodule LINEDevelopers.MessagingAPIStub do
  @behaviour LINEDevelopers.MessagingAPISpec

  require Logger

  @impl LINEDevelopers.MessagingAPISpec
  def reply!(x1, x2, [m|_] = x3)
  when is_binary(x1) and is_binary(x2) and is_map(m),
    do: log(:reply!, [x1, x2, x3])

  @impl LINEDevelopers.MessagingAPISpec
  def push!(x1, x2, [m|_] = x3, x4 \\ [])
  when is_binary(x1) and is_binary(x2) and is_map(m),
    do: log(:push!, [x1, x2, x3, x4])

  @impl LINEDevelopers.MessagingAPISpec
  def multicast!(x1, [t|_] = x2, [m|_] = x3, x4 \\ [])
  when is_binary(x1) and is_binary(t) and is_map(m),
    do: log(:multicast!, [x1, x2, x3, x4])

  @impl LINEDevelopers.MessagingAPISpec
  def broadcast!(x1, [m|_] = x2, x3 \\ [])
  when is_binary(x1) and is_map(m),
    do: log(:broadcast!, [x1, x2, x3])

  @impl LINEDevelopers.MessagingAPISpec
  def narrowcast!(x1, [m|_] = x2, x3, x4, x5, x6 \\ [])
  when is_binary(x1) and is_map(m),
    do: log(:narrowcast!, [x1, x2, x3, x4, x5, x6])

  @impl LINEDevelopers.MessagingAPISpec
  def progress_narrowcast!(x1, x2)
  when is_binary(x1) and is_binary(x2) do
    log(:progress_narrowcast!, [x1, x2])

    {:ok, {200, %{"phase" => "succeeded", "successCount" => 999}, []}}
  end

  @impl LINEDevelopers.MessagingAPISpec
  def get_audience!(x1, x2)
  when is_binary(x1) and is_integer(x2) do
    log(:get_audience!, [x1, x2])

    data = %{
      "audienceGroup" => %{
        "audienceGroupId" => 1234567890123,
        "createRoute" => "OA_MANAGER",
        "type" => "UPLOAD",
        "description" => "audienceGroupName_01",
        "status" => "READY",
        "audienceCount" => 1887,
        "created" => 1608617466,
        "permission" => "READ",
        "isIfaAudience" => false,
        "expireTimestamp" => 1624342266
      },
      "jobs" => [
        %{
          "audienceGroupJobId" => 12345678,
          "audienceGroupId" => 1234567890123,
          "description" => "audience_list.txt",
          "type" => "DIFF_ADD",
          "status" => "FINISHED",
          "failedType" => nil,
          "audienceCount" => 0,
          "created" => 1608617472,
          "jobStatus" => "FINISHED"
        }
      ]
    }

    {:ok, {200, data, []}}
  end

  @impl LINEDevelopers.MessagingAPISpec
  def create_audience!(x1, x2 \\ "stub-audience", [t|_] = x3)
  when is_binary(x1) and is_binary(x2) and is_binary(t) do
    log(:create_audience!, [x1, x2, x3])
    {:ok, {200, %{"audienceGroupId" => 9999999999999}, []}}
  end

  @impl LINEDevelopers.MessagingAPISpec
  def merge_audience!(x1, x2, x3 \\ "stub-audience", [t|_] = x4)
  when is_binary(x1) and is_integer(x2) and is_binary(x3) and is_binary(t),
    do: log(:merge_audience!, [x1, x2, x3, x4])

  @impl LINEDevelopers.MessagingAPISpec
  def delete_audience!(x1, x2)
  when is_binary(x1) and is_integer(x2),
    do: log(:delete_audience!, [x1, x2])

  @impl LINEDevelopers.MessagingAPISpec
  def create_richmenu!(x1, x2)
  when is_binary(x1) and is_map(x2) do
    log(:create_richmenu!, [x1, x2])
    {:ok, {200, %{"richMenuId" => "RICHMENUID"}, []}}
  end

  @impl LINEDevelopers.MessagingAPISpec
  def delete_richmenu!(x1, x2)
  when is_binary(x1) and is_binary(x2),
    do: log(:delete_richmenu!, [x1, x2])

  @impl LINEDevelopers.MessagingAPISpec
  def content_richmenu!(x1, x2, x3)
  when is_binary(x1) and is_binary(x2) and is_binary(x3),
    do: log(:content_richmenu!, [x1, x2, x3])

  @impl LINEDevelopers.MessagingAPISpec
  def all_richmenu!(x1, x2)
  when is_binary(x1) and is_binary(x2),
    do: log(:all_richmenu!, [x1, x2])

  @impl LINEDevelopers.MessagingAPISpec
  def link_richmenu!(x1, x2, [t|_] = x3)
  when is_binary(x1) and is_binary(x2) and is_binary(t),
    do: log(:link_richmenu!, [x1, x2, x3])

  @impl LINEDevelopers.MessagingAPISpec
  def unlink_richmenu!(x1, [t|_] = x2)
  when is_binary(x1) and is_binary(t),
    do: log(:unlink_richmenu!, [x1, x2])

  @impl LINEDevelopers.MessagingAPISpec
  def alias_richmenu!(x1, x2, x3)
  when is_binary(x1) and is_binary(x2) and is_binary(x3),
    do: log(:alias_richmenu!, [x1, x2, x3])

  @impl LINEDevelopers.MessagingAPISpec
  def unalias_richmenu!(x1, x2)
  when is_binary(x1) and is_binary(x2),
    do: log(:unalias_richmenu!, [x1, x2])

  @impl LINEDevelopers.MessagingAPISpec
  def get_richmenu!(x1, x2)
  when is_binary(x1) and is_binary(x2) do
    log(:get_richmenu!, [x1, x2])

    data = %{
      "richMenuId" => "RICHMENUID",
      "name" => "Nice rich menu",
      "size" => %{
        "width" => 2500,
        "height" => 1686
      },
      "chatBarText" => "Tap to open",
      "selected" => false,
      "areas" => [
        %{
          "bounds" => %{
            "x" => 0,
            "y" => 0,
            "width" => 2500,
            "height" => 1686
          },
          "action" => %{
            "type" => "postback",
            "data" => "action=buy&itemid=123"
          }
        }
      ]
    }

    {:ok, {200, data, []}}
  end

  @impl LINEDevelopers.MessagingAPISpec
  def list_richmenu!(x1) when is_binary(x1) do
    log(:list_richmenu!, [x1])

    data = %{
      "richmenus" => [
      %{
        "richMenuId" => "RICHMENUID",
        "name" => "Nice rich menu",
        "size" => %{
          "width" => 2500,
          "height" => 1686
        },
        "chatBarText" => "Tap to open",
        "selected" => false,
        "areas" => [
          %{
            "bounds" => %{
              "x" => 0,
              "y" => 0,
              "width" => 2500,
              "height" => 1686
            },
            "action" => %{
              "type" => "postback",
              "data" => "action=buy&itemid=123"
            }
          }
        ]
      }
    ]
    }

    {:ok, {200, data, []}}
  end

  @impl LINEDevelopers.MessagingAPISpec
  def get_profile!(x1, user_id)
  when is_binary(x1) and is_binary(user_id) do
    log(:get_profile!, [x1, user_id])

    data = %{
      "displayName" => "Messaging API Stub",
      "userId" => user_id,
      "language" => "en",
      "pictureUrl" => "https://obs.line-apps.com/...",
      "statusMessage" => "Hello, LINE!"
    }

    {:ok, {200, data, []}}
  end

  defp log(x, p) do
    "You now on stub: #{__MODULE__}:#{x}, "
    |> Kernel.<>(inspect(p))
    |> Logger.warning

    {:ok, {200, %{}, [{"x-line-request-id", "XLINEREQUESTID"}]}}
  end
end
