class MessagesController < ApplicationController
    before_action :authenticate_user!
    def create
        room = Room.find(message_params[:room_id])
        @message = Message.new(message_params)
        @message.sent_by = current_user.id
        if @message.save
            SendMessageJob.perform_later(@message, current_user)
            # room.users.find_each do |user|
            #     if(user != @message.sent_by)
            #     Notification.create(recipient: user, user: current_user, action: "messaged", notifiable: user)
            #     notification = Notification.last
            #     ApplicationController.render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats:[:html]
            #     NotificationRelayJob.perform_later(notification)
            #     end
            # end
            redirect_to request.referrer
        end
    end

    private
        def message_params
            params.require(:message).permit(:text, :room_id, :sent_by)
        end
end
