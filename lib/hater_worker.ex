defmodule HaterWorker do
  use Que.Worker, concurrency: 10

  def perform(update) do
    hate(update)
  end

  def hate(update) do
    %{
      chat: %{id: chat_id},
      message_id: message_id,
      text: text,
      voice: voice
    } = parse_message(update)

    case voice do
      nil ->
        {:ok, :pass}

      _voice ->
        Nadia.send_sticker(chat_id, get_sticker(), reply_to_message_id: message_id)
    end

    {text, chat_id, message_id}
  end

  @spec parse_message(%Nadia.Model.Update{}) :: %Nadia.Model.Message{}
  def parse_message(update) do
    update.message || update.channel_post
  end

  defp get_sticker do
    stickers = [
      "CAACAgIAAx0CVbTqhgACByZgESqrXBG35hBqtVlQ_xCdmmfuLwACWwADLEFmGSVEgGM8SxEbHgQ",
      "CAACAgIAAxkBAAMVYBAeFbVA1re0kS22lwy2Y0sVKpUAAl0AA33XWRFpMUFz8IeUXx4E",
      "CAACAgIAAx0CVbTqhgACBydgESriLp6Yvemk4a5Xus3-lLZg2QACaAAD_WKhC8FAQIoUsmFiHgQ"
    ]

    Enum.random(stickers)
  end
end
