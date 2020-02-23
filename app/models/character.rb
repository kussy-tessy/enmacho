class Character < ApplicationRecord
    belongs_to :work, optional: true
    has_many :kigurumis
end
