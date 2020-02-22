class Character < ApplicationRecord
    belongs_to :work
    has_many :kigurumis
end
