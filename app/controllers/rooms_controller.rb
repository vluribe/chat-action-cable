class RoomsController < ApplicationController
    before_action :authenticate_user!
    def index
        @rooms = Room.all
        @notifications = Notification.where(recipient_id: current_user.id).find_each 
    end

    def show
        @rooms = Room.all
        @room = Room.find_by(id: params[:id])
        if !@room 
            @error = "Room not found :("
        end
        render "index"
    end

    def create
        @room = Room.new(room_params)
        if !(@room.valid?)
            @ex = Room.find_by(name: @room.name)
            redirect_to "/rooms/"+@ex.id.to_s
        else
            if @room.save
                redirect_to action: :show, id: @room.id
            else
                redirect_to action: :index
            end
        end
    end

    private
        def room_params
            params.require(:room).permit(:name)
        end
end
