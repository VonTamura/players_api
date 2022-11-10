require 'rails_helper'

RSpec.describe 'Players', type: :request do
  describe 'GET /players' do
    before { get '/players' }

    it 'should return OK' do
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(response).to have_http_status(200)
    end
  end

  describe 'whit data in the DB' do
    let!(:player) { create_list(:player, 10) }

    it 'should return all players' do
      get '/players'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(player.size)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /players/{id}' do
    let(:player) { create(:player) }

    it 'should return a player' do
      get "/players/#{player.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload['id']).to eq(player.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /players' do

    it 'should return a player' do
      req_payload = {
        "jugadores": [
          {
            "nombre": "Irving Alamo",
            "nivel": "B",
            "goles": 10,
            "sueldo": 100000,
            "bono": 25000,
            "sueldo_completo":nil,
            "equipo": "rojo"
          },
          {
            "nombre": "Alberto Hernandez",
            "nivel": "A",
            "goles": 5,
            "sueldo": 150000,
            "bono": 10000,
            "sueldo_completo":nil,
            "equipo": "azul"
          }
        ]
      }
      post '/players', params: req_payload
      payload = JSON.parse(response.body)

      expect(payload.last).to_not be_empty
      expect(payload.last['id']).to_not be_nil
      expect(response).to have_http_status(:created)
    end

    it 'should return error message on invalid post player' do
      req_payload = {
        "jugadores": [
          {
            "nivel": "B",
            "goles": 10,
            "sueldo": 100000,
            "bono": 25000,
            "sueldo_completo":nil,
            "equipo": "rojo"
          },
          {
            "nombre": "Alberto Hernandez",
            "nivel": 16,
            "goles": 5,
            "sueldo": 150000,
            "bono": 10000,
            "sueldo_completo":nil,
            "equipo": "azul"
          }
        ]
      }
      post '/players', params: req_payload
      payload = JSON.parse(response.body)

      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_empty
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

  describe 'PUT /players/{id}' do
    let!(:player) { create(:player) }

    it 'should modify a player' do
      req_payload = {
        "jugadores": [
          {
            "id": player.id,
            "nombre": "Irving Alamo",
            "nivel": "B",
            "goles": 1,
            "sueldo": 200000,
            "bono": 25000,
            "equipo": "azul"
          }
        ]
      }
      put "/players/#{player.id}", params: req_payload
      payload = JSON.parse(response.body)

      expect(payload).to_not be_empty
      expect(payload['id']).to eq(player.id)
      expect(response).to have_http_status(:ok)
    end

    it 'should return error message on invalid put player' do
      req_payload = {
        "jugadores": [
          {
            "id": nil,
            "nombre": nil
          }
        ]
      }
      put "/players/#{player.id}", params: req_payload
      payload = JSON.parse(response.body)

      expect(payload).to_not be_empty
      expect(payload['error']).to_not be_nil
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
