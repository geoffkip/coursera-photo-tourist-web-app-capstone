require 'rails_helper'

RSpec.describe "States", type: :request do

  def parsed_body
    JSON.parse(response.body)
  end

  describe 'States MongoDB-backed' do
    before(:each) { State.delete_all }
    after(:each)  { State.delete_all }

    it 'create States MongoDB-backed model' do
      obj = State.create(name: 'Maryland')
      expect(State.find(obj.id).name).to eq('Maryland')
    end

    it 'expose States MongoDb-backed API resource' do
      obj = State.create(name: 'Maryland')
      expect(states_path).to eq('/api/states')
      get (state_path(obj.id))
      expect(response).to have_http_status(:ok)
      expect(parsed_body['name']).to eq('Maryland')
      expect(parsed_body).to include('created_at')
      expect(parsed_body).to include('id' => obj.id.to_s)
    end
  end
end