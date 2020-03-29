class Kigurumi < ApplicationRecord
  belongs_to :character
  belongs_to :factory, optional: true
  belongs_to :customizer, class_name: 'Person', optional: true
  belongs_to :owner, class_name: 'Person', optional: true
  belongs_to :previous_owner, class_name: 'Person', optional: true
  has_many :kigurumi_images

  scope :search, -> (params) do
    character_name_is(params[:character_name])
      .work_name_is(params[:work_name])
      .factory_id_is(params[:factory_id])
  end

  scope :character_name_is, -> (character_name) { where(character: Character.find_by(name: character_name).presence || -1 ) if character_name.present? }
  scope :work_name_is, -> (work_name) { where(character: Character.where(work: Work.find_by(name: work_name)).presence || -1 ) if work_name.present? }
  scope :factory_id_is, -> (factory_id) { where(factory_id: factory_id) if factory_id.present? }
end
