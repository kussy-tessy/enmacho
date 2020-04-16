class KigurumiForm
  include ActiveModel::Model
  attr_accessor :id, :owner_name, :owner_twitter, :character_name, :work_name, 
      :is_original, :factory_id, :customizer_name, :customizer_twitter, :previous_owner_name, 
      :previous_owner_twitter, :show_year, :remarks, :hair_color,
      :hair_length, :mouth_open, :kigurumi_images

  validates :owner_name, presence: {message: 'この項目は必須です'}
  validates :owner_twitter, format: { with: /\A[_a-zA-Z0-9]*\z/, message: '無効なTwitterIDです'}
  validates :customizer_name, presence: {message: 'この項目の名前は必須です。TwitterIDを入力しなおしてください'}, if: Proc.new { |f| f.customizer_twitter.present? }
  validates :customizer_twitter,  format: { with: /\A[_a-zA-Z0-9]*\z/, message: '無効なTwitterIDです'}
  validates :previous_owner_name, presence: {message: 'この項目の名前は必須です。TwitterIDを入力しなおしてください'}, if: Proc.new { |f| f.previous_owner_twitter.present? }
  validates :previous_owner_twitter,  format: { with: /\A[_a-zA-Z0-9]*\z/, message: '無効なTwitterIDです'}
  validates :show_year, numericality: {only_integer: true, allow_blank: true, message: '数字だけにしてください'}
  validate :kigurumi_images_should_twitter_url
  validate :should_include_character_or_kigurumi_images
  validate :should_include_character_name_when_has_work_name
  validate :should_include_work_name_when_is_not_original

  def kigurumi_images_should_twitter_url
    @kigurumi_images.each do |image|
      if image.present? && !image.match?(/^https:\/\/twitter.com\/.+\/status\/\d+/)
        errors.add(:kigurumi_images, '無効なURLが含まれています。TwitterのURLを入力してください。')
      end
    end
    return true
  end

  def should_include_character_or_kigurumi_images
    if @character_name.empty? && @kigurumi_images.filter{|url| url.present?}.empty?
      errors.add(:character_name, 'この項目は必須です。もしくは画像を入力してください')
    end
    return true
  end

  def should_include_character_name_when_has_work_name
    if @work_name.present? && @character_name.empty?
      errors.add(:character_name, 'この項目は必須です。作品名だけを登録することはできません')
    end
  end

  def should_include_work_name_when_is_not_original
    if @work_name.empty? && @is_original.to_i == 0 && @kigurumi_images.filter{|url| url.present?}.empty?
      errors.add(:work_name, 'オリジナルでない場合、この項目は必須です。')
    end
    if @work_name.empty? && @character_name.present? && @is_original.to_i == 0
      errors.add(:work_name, 'オリジナルでない場合、この項目は必須です。')
    end
  end

  def initialize(kigurumi)
    self.id = kigurumi.id
    self.owner_name = kigurumi.owner&.name
    self.owner_twitter = kigurumi.owner&.twitter
    self.character_name = kigurumi.character&.name
    self.work_name = kigurumi.character&.work&.name
    self.is_original = kigurumi.character && !kigurumi.character&.work
    self.factory_id = kigurumi.factory&.id
    self.customizer_name = kigurumi.customizer&.name
    self.customizer_twitter = kigurumi.customizer&.twitter
    self.previous_owner_name = kigurumi.previous_owner&.name
    self.previous_owner_twitter = kigurumi.previous_owner&.twitter
    self.show_year = kigurumi.show_year
    self.remarks = kigurumi.remarks
    self.hair_color = kigurumi.hair_color_before_type_cast
    self.hair_length = kigurumi.hair_length_before_type_cast
    self.mouth_open = kigurumi.mouth_open_before_type_cast
    self.kigurumi_images = kigurumi.kigurumi_images&.map(&:url).filter{|url| url.present?}
  end

  def update(params)
    self.attributes = params
  end

  def save
    return false if invalid?

    @kigurumi = self.id.present? ? Kigurumi.find(self.id) : Kigurumi.new
    twitter = self.owner_twitter.presence || nil
    owner = Person.find_or_create_by!(name: self.owner_name, twitter: twitter)
    
    if previous_owner_name.present?
      previous_owner_twitter = self.previous_owner_twitter.presence || nil
      previous_owner = Person.find_or_create_by!(name: self.previous_owner_name, twitter: previous_owner_twitter)
      @kigurumi.previous_owner = previous_owner
    end  

    if customizer_name.present?
      customizer_twitter = self.customizer_twitter.presence || nil
      customizer = Person.find_or_create_by!(name: self.customizer_name, twitter: self.customizer_twitter)
      @kigurumi.customizer = customizer
    end

    work = self.work_name.present? ? Work.find_or_create_by!(name: self.work_name) : nil
    character = self.character_name.present? ? Character.find_or_create_by!(name: self.character_name) : nil
    character&.work = work
    character&.save!
    factory = self.factory_id.present? ? Factory.find(self.factory_id) : nil
    
    @kigurumi.owner = owner
    @kigurumi.character = character
    @kigurumi.factory = factory
    @kigurumi.remarks = self.remarks.presence || nil
    @kigurumi.show_year = self.show_year.presence || nil
    @kigurumi.hair_color = self.hair_color.present? ? self.hair_color.to_i : nil
    @kigurumi.hair_length = self.hair_length.present? ? self.hair_length.to_i : nil
    @kigurumi.mouth_open = self.mouth_open.present? ? self.mouth_open.to_i : nil
    @kigurumi.save!
    kigurumi_images = self.kigurumi_images&.filter{|url| url.present?}
    @kigurumi.kigurumi_images.destroy_all
    @kigurumi.kigurumi_images.create!(kigurumi_images.map{|image| {url: image} })
    return @kigurumi
  end
end