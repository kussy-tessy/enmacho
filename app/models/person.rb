class Person < ApplicationRecord
    has_many :kigurumis, inverse_of: 'owner', foreign_key: 'owner_id'
    has_many :customized_kigurumis, class_name: 'Kigurumi', inverse_of: 'customizer', foreign_key: 'customizer'
    has_many :previous_owned_kigurumis, class_name: 'Kigurumi', inverse_of: 'previous_owner', foreign_key: 'previous_owner'
    belongs_to :prefecture
    belongs_to :home_prefecture, class_name: 'Prefecture', inverse_of: 'from_people'
end
