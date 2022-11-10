class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show update destroy ]

  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end

  # GET /players
  def index
    @players = Player.all

    render json: @players, status: :ok
  end

  # GET /players/1
  def show
    render json: @player, status: :ok
  end

  # POST /players
  def create
    @player = Player.create!(player_params['players'])
    render json: @player, status: :created
  end

  # PUT /players/1
  def update
    @player = Player.find(translated_params['players'].first['id'])
    @player.update!(update_params['players'].first)
    render json: @player, status: :ok
  end

  # DELETE /players/1
  def destroy
    @player.destroy
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    translated_params.permit(players: [:name,
                                       :level,
                                       :goals,
                                       :salary,
                                       :bonus,
                                       :total_salary,
                                       :team])
  end

  def update_params
    translated_params.permit(players: [:name,
                                       :level,
                                       :goals,
                                       :salary,
                                       :bonus,
                                       :team])
  end

  def translated_params
    TranslationRequest.new(params).translate_keys
  end
end
