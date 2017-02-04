require 'rails_helper'

RSpec.describe "Cities", type: :request do

  def parsed_body
    JSON.parse(response.body)
  end

  describe 'Cities RDBMS-backed' do
    before(:each) { City.delete_all }
    after(:each)  { City.delete_all }

    it 'create Cities RDBMS-backed model' do
      obj = City.create(name: 'Baltimore')
      expect(City.find(obj.id).name).to eq('Baltimore')
    end
    it 'expose Cities RDBMS-backed API resource' do
      obj = City.create(name: 'Baltimore')
      expect(cities_path).to eq('/api/cities')
      get city_path(obj.id)
      expect(response).to have_http_status(:ok)
      expect(parsed_body['name']).to eq('Baltimore')
    end
  end
end