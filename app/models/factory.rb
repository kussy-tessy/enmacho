class Factory < ApplicationRecord
  default_scope { order(:updated_at)  }
  has_many :kigurumis
end
