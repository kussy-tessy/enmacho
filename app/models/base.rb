class Base < ApplicationRecord
  belongs_to :factory
  has_many :kigurumis
end
