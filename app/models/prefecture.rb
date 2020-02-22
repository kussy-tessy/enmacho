class Prefecture < ApplicationRecord
    has_many :people
    has_many :from_people, class_name: 'Person'
end
