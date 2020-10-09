class RoomsController < ApplicationController
    def index
        @rooms = Room.all
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
        if @room.save
            redirect_to action: :show, id: @room.id
        else
            redirect_to action: :index
        end
    end

    private
        def room_params
            params.require(:room).permit(:name)
        end
end