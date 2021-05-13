FactoryBot.define do
  sequence :string, aliases: %i[name description] do |n|
    "string-#{n}"
  end
end
