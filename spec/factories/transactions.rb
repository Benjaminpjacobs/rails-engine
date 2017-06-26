FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number "MyString"
    result "MyString"
  end
end
