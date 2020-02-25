class Kigurumi < ApplicationRecord
    belongs_to :character
    belongs_to :factory, optional: true
    belongs_to :customizer, class_name: 'Person', optional: true
    belongs_to :base, optional: true
    belongs_to :owner, class_name: 'Person', optional: true
    belongs_to :previous_owner, class_name: 'Person', optional: true
    has_many :kigurumi_images
end
