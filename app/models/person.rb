require 'date'

class Person < ApplicationRecord
  attr_writer :birth_month, :birth_day
  validates :name, presence: {message: '必須です'}
  validates :twitter, uniqueness: {message: '他のデータと重複しています'}, allow_nil: true
  validates :twitter, format: { with: /\A[_a-zA-Z0-9]*\z/, message: '不正なTwitterIDです'}
  validates :birth_year, numericality: {only_integer: true, allow_blank: true, message: '数字だけにしてください'}
  validate :month_and_day_can_be_date

  before_save :combine_month_day, :to_nil

  scope :search, -> (params) do
    name_is(params[:name])
      .twitter_is(params[:twitter])
      .prefecture_id_is(params[:prefecture_id])
      .age_from_is(params[:age_from])
      .age_to_is(params[:age_to])
  end

  scope :name_is, -> (name) { where('name like ?', '%'+name+'%') if name.present?} 
  scope :twitter_is, -> (twitter) { where('twitter like ?', '%'+twitter+'%') if twitter.present?} 
  scope :prefecture_id_is, -> (prefecture_id) { where(prefecture_id: prefecture_id) if prefecture_id.present?} 
  scope :age_from_is, -> (age_from) do
    where('(birth_is_reliable = :reliable and ((birth_year = :year and birthday < :date) or birth_year < :year)) or (birth_is_reliable = :not_reliable and birth_year <= :year)',
      {reliable: true, not_reliable: false, year: Date.today.year.to_i - age_from.to_i, date: Date.new(1900, Date.today.month, Date.today.day) }
    ) if age_from.present? 
    end
  scope :age_to_is, -> (age_to) do
    where('(birth_is_reliable = :reliable and (birth_year = :year and birthday > :date or birth_year > :year)) or (birth_is_reliable = :not_reliable and birth_year >= :year)',
      {reliable: true, not_reliable: false, year: Date.today.year.to_i - age_to.to_i - 1, date: Date.new(1900, Date.today.month, Date.today.day) }
    ) if age_to.present? 
    end

  def month_and_day_can_be_date
    if @birth_month.present? || @birth_day.present?
      unless Date.valid_date?(@birth_year || 2020, @birth_month.to_i, @birth_day.to_i)
        errors.add(:birth_month, "無効な日付です")
      end
    end
    return true
  end

  has_many :kigurumis, inverse_of: 'owner', foreign_key: 'owner_id'
  has_many :customized_kigurumis, class_name: 'Kigurumi', inverse_of: 'customizer', foreign_key: 'customizer'
  has_many :previous_owned_kigurumis, class_name: 'Kigurumi', inverse_of: 'previous_owner', foreign_key: 'previous_owner'
  belongs_to :prefecture, optional: true
  belongs_to :home_prefecture, class_name: 'Prefecture', inverse_of: 'from_people', optional: true

  def name_with_twitter
    "#{self.name}(@#{self.twitter})"
  end

  def birth_month
    self.birthday&.month
  end

  def birth_day
    self.birthday&.day
  end

  def birth_year_dsp
    if self.birth_year
      if self.birth_is_reliable
        return "#{self.birth_year}年"
      else
        return "#{self.birth_year}年？"
      end
    else
      return nil 
    end
  end

  def birthday_dsp
    self.birthday&.strftime("%-m月%-d日")
  end

  def age
    if self.birth_year
      if self.birth_month && self.birth_day
        age_calc = (Date.today.strftime('%Y%m%d').to_i - Date.new(self.birth_year, self.birth_month, self.birth_day).strftime('%Y%m%d').to_i) / 10000
      else 
        age_calc = Date.today.year - birth_year
      end
      if self.birth_is_reliable && self.birth_day.present?
        return "#{age_calc}歳"
      else
        return "#{age_calc}歳？"
      end 
    else
      return nil
    end
  end

  private
    def combine_month_day
      if @birth_month.present? && @birth_day.present?
        self.birthday = Date.new(1900, @birth_month.to_i, @birth_day.to_i)
      else
        self.birthday = nil
      end
    end

    def to_nil
      self.twitter = self.twitter.presence
      self.other_name = self.other_name.presence
      self.yomigana = self.yomigana.presence
      self.remarks = self.remarks.presence
    end
end
