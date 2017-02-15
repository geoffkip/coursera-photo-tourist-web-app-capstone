# Added validation to name attribute class to Foo class
class Foo < ActiveRecord::Base
      validates :name, presence: true, length: { :minimum => 3} 
end

