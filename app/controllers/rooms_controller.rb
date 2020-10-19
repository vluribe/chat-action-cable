class RoomsController < ApplicationController
    before_action :authenticate_user!
    def index
        @rooms = Room.all
        @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).find_each
    end

    def show
        @rooms = current_user.rooms.all
        @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).find_each 
        @room = Room.find_by(id: params[:id])
        if !@room 
            @error = "Room not found :("
        end
        render "index"
    end

    def create
        @room = Room.new(room_params)
        if @room.save
            current_user.relation_userrooms.new(room:@room).save
            redirect_to action: :show, id: @room.id
        else
            room_add = Room.find_by(name:room_params[:name])
            relation = current_user.relation_userrooms.find_by(room_id: room_add.id)
            if relation
                redirect_to "/rooms/"+room_add.id.to_s
            else
                current_user.relation_userrooms.new(room: room_add).save
                redirect_to "/rooms/"+room_add.id.to_s
            end
        end
    end

    private
        def room_params
            params.require(:room).permit(:name)
        end
end
