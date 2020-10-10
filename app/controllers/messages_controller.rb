class MessagesController < ApplicationController
    before_action :authenticate_user!
    def create
        @message = Message.new(message_params)
        @message.sent_by = current_user.id
        @message.save
        SendMessageJob.perform_later(@message)
        redirect_to request.referrer
    end

    private
        def message_params
            params.require(:message).permit(:text, :room_id, :sent_by)
        end
end
