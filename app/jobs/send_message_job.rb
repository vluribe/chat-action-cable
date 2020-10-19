class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message, current_user)
    html = ApplicationController.render(
      partial: "messages/message",
      locals:{ message: message}
    )
    message.room.users.where.not(id: current_user.id).find_each do |user|
      ActionCable.server.broadcast("room_channel_#{message.room_id}_user_#{user.id}", html: html)
    end
  end
end
