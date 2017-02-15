json.errors do
  @foo.errors.messages.each do |k, v|
    json.set! k, v
  end
  json.full_messages @foo.errors.full_messages
end