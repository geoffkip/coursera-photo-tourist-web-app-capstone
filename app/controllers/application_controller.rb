# Added method to rescue 500/422 errors using ActiveRecords::StatementInvalid subclass
class ApplicationController < ActionController::API
  #make the connection between controller action and associated view
  include ActionController::ImplicitRender
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::StatementInvalid , with: :process_unprocessable_entity
  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found
  protected
    def record_not_found(exception) 
        payload = {
          errors: { full_messages:["cannot find id[#{params[:id]}]"] }
        }
        render :json=>payload, :status=>:not_found
        Rails.logger.debug exception.message
    end
    def process_unprocessable_entity(exception)     
         error_payload = {
             errors: { "field_name1"=>["error1","error2"],
                       "field_name2"=>["error1"],
                       "full_messages"=>[Foo.errors[:name]]
                      }
                    }
         render :json=>error_payload, :status=>:unprocessable_entity #:internal_server_error #
         Rails.logger.debug exception.message
     end
  end
