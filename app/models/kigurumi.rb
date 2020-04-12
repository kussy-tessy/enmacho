class Kigurumi < ApplicationRecord
  enum hair_color: {
    '赤色' => 1,
    'ピンク色' => 2,
    'オレンジ色' => 3,
    '黄色' => 4,
    '緑色' => 5,
    '青色、藍色' => 6,
    '水色' => 7,
    '紫色' => 8,
    '白色、銀色' => 9,
    '茶色' =>10,
    '黒色' =>11,
    'クリーム色' =>12
  }

  enum hair_length: {
    '短い（首〜肩まで）' => 1,
    '中程度（肩〜胸まで）' => 2,
    '長い（腰〜脚まで）' => 3
  }

  enum mouth_open: {
    '口開き' => 1,
    '口閉じ' => 2
  }

  belongs_to :character, optional: true
  belongs_to :factory, optional: true
  belongs_to :customizer, class_name: 'Person', optional: true
  belongs_to :owner, class_name: 'Person', optional: true
  belongs_to :previous_owner, class_name: 'Person', optional: true
  has_many :kigurumi_images

  scope :search, -> (params) do
    character_name_is(params[:character_name])
      .work_name_is(params[:work_name])
      .factory_id_is(params[:factory_id])
      .hair_color_is(params[:hair_color])
      .hair_length_is(params[:hair_length])
      .mouth_open_is(params[:mouth_open])
  end

  scope :character_name_is, -> (character_name) { where(character: Character.find_by(name: character_name).presence || -1 ) if character_name.present? }
  scope :work_name_is, -> (work_name) { where(character: Character.where(work: Work.find_by(name: work_name)).presence || -1 ) if work_name.present? }
  scope :factory_id_is, -> (factory_id) { where(factory_id: factory_id) if factory_id.present? }
  scope :hair_color_is, -> (hair_color) { where(hair_color: hair_color) if hair_color.present? }
  scope :hair_length_is, -> (hair_length) { where(hair_length: hair_length) if hair_length.present? }
  scope :mouth_open_is, -> (mouth_open) { where(mouth_open: mouth_open) if mouth_open.present? }
end
