# Added test methods for ActiveRecords::StatementInvalid 
require 'rails_helper'
RSpec.describe "FooApiErrorReportings", type: :request do
  describe "API error reporting for Foo class" do  
    it "invalid Foo reports API error" do
      expect{jpost foos_path, :foo=>{:id=>1}}.to_not raise_error
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:unprocessable_entity)
      payload=parsed_body
      pp payload
      expect(payload).to have_key("errors")
      expect(payload["errors"]).to have_key("name") 
      expect(payload["errors"]["name"]).to be_an(Array)
      expect(payload["errors"]).to have_key("full_messages")
      expect(payload["errors"]["full_messages"]).to be_an(Array)
    end
  end
end


