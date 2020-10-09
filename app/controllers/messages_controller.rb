class MessagesController < ApplicationController
    def create
        @message = Message.new(message_params)
        @message.save
        SendMessageJob.perform_later(@message)
        redirect_to request.referrer
    end

    private
        def message_params
            params.require(:message).permit(:text, :room_id)
        end
end
