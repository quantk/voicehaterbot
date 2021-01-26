defmodule HaterWorker do
  use Que.Worker, concurrency: 10
  def perform(update) do
    hate(update)
  end

  def hate(update) do
    message = parse_message(update)
    chat_id = message.chat.id
    message_id = message.message_id
    text = message.text

    case message.voice do
      nil -> {:ok, :pass}
      _voice ->
        Nadia.send_sticker(chat_id, "CAACAgIAAxkBAAMVYBAeFbVA1re0kS22lwy2Y0sVKpUAAl0AA33XWRFpMUFz8IeUXx4E", reply_to_message_id: message_id)
    end

    {text, chat_id, message_id}
  end

  @spec parse_message(%Nadia.Model.Update{}) :: %Nadia.Model.Message{}
  def parse_message(update) do
    update.message || update.channel_post
  end
end
