class Character < ApplicationRecord
  belongs_to :work, optional: true
  has_many :kigurumis

  def name_with_work
    "#{self.name}(#{self.work&.name || 'オリジナル'})"
  end
end
