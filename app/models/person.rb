require 'date'

class Person < ApplicationRecord
  attr_writer :birth_month, :birth_day
  validates :twitter, uniqueness: {message: '重複しています'}, allow_nil: true
  validate :month_and_day_can_be_date
  before_save :combine_month_day

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
      age_calc = (Date.today.strftime('%Y%m%d').to_i - Date.new(self.birth_year, self.birth_month, self.birth_day).strftime('%Y%m%d').to_i) / 10000
      if self.birth_is_reliable
        return "#{age_calc}歳"
      else
        return "#{age_calc}歳？"
      end
    end
    return nil
  end

  private
    def combine_month_day
      if @birth_month.present? && @birth_day.present?
        self.birthday = Date.new(2020, @birth_month.to_i, @birth_day.to_i)
      end
    end
end
