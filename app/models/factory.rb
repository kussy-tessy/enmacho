class Factory < ApplicationRecord
    has_many :bases, class_name: 'Base'
    has_many :kigurumis
end
