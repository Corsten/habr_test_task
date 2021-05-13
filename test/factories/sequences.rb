FactoryBot.define do
  sequence :string, aliases: %i[name description] do |n|
    "string-#{n}"
  end

  sequence :queue_hash do
    SecureRandom.hex 32
  end
end
