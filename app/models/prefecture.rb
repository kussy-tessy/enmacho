class Prefecture < ApplicationRecord
  default_scope { order(:updated_at)  }

  has_many :people
  has_many :from_people, class_name: 'Person'
end
