class KigurumiForm
  include ActiveModel::Model
  attr_accessor :id, :owner_name, :owner_twitter, :character_name, :work_name, 
      :factory_id, :customizer_name, :customizer_twitter, :previous_owner_name, 
      :previous_owner_twitter, :show_year, :remarks, :kigurumi_images

  validates :owner_name, presence: true
  validates :character_name, presence: true
  validates :owner_twitter, format: { with: /\A[_a-zA-Z0-9]*\z/, message: '無効なTwitterID'}
  validates :customizer_twitter,  format: { with: /\A[_a-zA-Z0-9]*\z/, message: '無効なTwitterID'}
  validates :previous_owner_twitter,  format: { with: /\A[_a-zA-Z0-9]*\z/, message: '無効なTwitterID'}
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
    self.owner_name = kigurumi.owner&.name
    self.owner_twitter = kigurumi.owner&.twitter
    self.character_name = kigurumi.character&.name
    self.work_name = kigurumi.character&.work&.name
    self.factory_id = kigurumi.factory&.id
    self.customizer_name = kigurumi.customizer&.name
    self.customizer_twitter = kigurumi.customizer&.twitter
    self.previous_owner_name = kigurumi.previous_owner&.name
    self.previous_owner_twitter = kigurumi.previous_owner&.twitter
    self.show_year = kigurumi.show_year
    self.remarks = kigurumi.remarks
    self.kigurumi_images = kigurumi.kigurumi_images&.map(&:url)
  end

  def update(params)
    self.attributes = params
  end

  def save
    return false if invalid?
    @kigurumi = self.id.present? ? Kigurumi.find(self.id) : Kigurumi.new
    twitter = self.owner_twitter.presence || nil
    owner = Person.find_or_create_by!(name: self.owner_name, twitter: twitter)
    
    previous_owner_twitter = self.previous_owner_twitter.presence || nil
    previous_owner = Person.find_or_create_by!(name: self.previous_owner_name, twitter: previous_owner_twitter)

    customizer_twitter = self.customizer_twitter.presence || nil
    customizer = Person.find_or_create_by!(name: self.customizer_name, twitter: self.customizer_twitter)

    work_name = self.work_name.presence || 'オリジナル'
    work = Work.find_or_create_by!(name: work_name)
    character = work.characters.find_or_create_by!(name: self.character_name)
    factory = self.factory_id.present? ? Factory.find(self.factory_id) : nil
    @kigurumi.owner = owner
    @kigurumi.previous_owner = previous_owner if self.previous_owner_name.present?
    @kigurumi.customizer = customizer if self.customizer_name.present?
    @kigurumi.character = character
    @kigurumi.factory = factory
    @kigurumi.remarks = self.remarks.presence || nil
    @kigurumi.show_year = self.show_year.presence || nil
    @kigurumi.save!
    kigurumi_images = self.kigurumi_images
    @kigurumi.kigurumi_images.destroy_all
    @kigurumi.kigurumi_images.create!(kigurumi_images.map{|image| {url: image} })
    return @kigurumi
  end
end