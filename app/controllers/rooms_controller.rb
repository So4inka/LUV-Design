class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]
  before_action :authorize_request, only: [:create, :update, :destroy]
  before_action :authorize

  # GET /rooms
  def index
    @rooms = Room.all

    render json: @rooms
  end

  # GET /rooms/1
  def show
    render json: @room, include: :items
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)
    @room.user = @current_user

    if @room.save
      render json: @room, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  def destroy
    @room.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end
 
    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name)
    end

    def authorize 
      @authorized_user = @room.user == @current_user
      if !@authorized_user 
        render json: 'Sorry, you are not authorized', status: :unauthorized
    end
    end
end
