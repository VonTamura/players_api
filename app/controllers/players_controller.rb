class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show update destroy ]

  # GET /players
  def index
    @players = Player.all

    render json: @players,status: :ok
  end

  # GET /players/1
  def show
    render json: @player, status: :ok
  end

  # POST /players
  def create
    @player = Player.create!(player_params["players"])
    #if @player.save
      render json: @player, status: :created
    #else
      #render json: @player.errors, status: :unprocessable_entity
    #end
  end

  # PATCH/PUT /players/1
  def update
    if @player.update(player_params)
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end
  
    def player_params
      translated_params = TranslationRequest.new(params).translate_keys
      translated_params.permit( players: [ :name, :level, :goals, :salary, :bonus, :total_salary, :team ] )
    end
end
