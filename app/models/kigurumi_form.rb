class KigurumiForm
  include ActiveModel::Model
  attr_accessor :id, :owner_name, :owner_twitter, :character_name, :work_name, 
      :factory_id, :customizer_name, :customizer_twitter, :previous_owner_name, 
      :previous_owner_twitter, :show_year, :remarks, :kigurumi_images

  validates :owner_name, presence: true
  validates :owner_twitter, format: { with: /\A[_a-zA-Z]*\z/, message: '英字のみ'}
  validates :customizer_twitter,  format: { with: /\A[_a-zA-Z]*\z/, message: '英字のみ'}
  validates :previous_owner_twitter,  format: { with: /\A[_a-zA-Z]*\z/, message: '英字のみ'}
  validates :show_year, numericality: {only_integer: true, allow_blank: true}
  validate :kigurumi_images_should_twitter_url

  def kigurumi_images_should_twitter_url
    @kigurumi_images.each do |image|
      if image.present? && !image.match(/https:\/\/twitter.com\/.+\/status\/\d+/)
        errors.add(:kigurumi_images, '無効なURLが含まれています')
      end
    end
    return true
  end

  def initialize(kigurumi)
    self.id = kigurumi.id
    self.owner_name = kigurumi.owner.name
    self.owner_twitter = kigurumi.owner.twitter
    self.character_name = kigurumi.character&.name
    self.work_name = kigurumi.character.work&.name
    self.factory_id = kigurumi.factory&.id
    self.customizer_name = kigurumi.customizer&.name
    self.customizer_twitter = kigurumi.customizer&.twitter
    self.previous_owner_name = kigurumi.previous_owner&.name
    self.previous_owner_twitter = kigurumi.previous_owner&.twitter
    self.show_year = kigurumi.show_year
    self.remarks = kigurumi.remarks
    self.kigurumi_images = kigurumi.kigurumi_images.map(&:url)
  end

  def update(params)
    self.attributes = params
  end

  def save
    return false if invalid?
    return true
  end
end