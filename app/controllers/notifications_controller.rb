class NotificationsController < ApplicationController

    def index
        @notifications  =  Notification.where(recipient_id: current_user.id).find_each 
    end

    def destroy
        @notification = Notification.find(params[:id])
        @notification.destroy
        redirect_to request.referrer
    end

    def show
        @notification = Notification.find(params[:id])
    end

end
