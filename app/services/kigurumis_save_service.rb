class KigurumisSaveService
  def initialize(params)
    @params = params
  end

  def save
    @kigurumi = @params[:id].present? ? Kigurumi.find(@params[:id]) : Kigurumi.new
    twitter = @params[:twitter].presence || nil
    person = Person.find_or_create_by!(name: @params[:person_name], twitter: twitter)

    work_name = @params[:work_name].presence || 'オリジナル'
    work = Work.find_or_create_by!(name: work_name)
    character = work.characters.find_or_create_by!(name: @params[:character_name])
    factory = @params[:factory_id].present? ? Factory.find(@params[:factory_id]) : nil
    base = @params[:base_id].present? ? Base.find(@params[:base_id]) : nil
    @kigurumi.character = character
    @kigurumi.factory = factory
    @kigurumi.base = base
    @kigurumi.save!
    kigurumi_images = @params['kigurumi_images']
    Rails.logger.debug(kigurumi_images)
    @kigurumi.kigurumi_images.destroy_all
    @kigurumi.kigurumi_images.create!(kigurumi_images.map{|image| {url: image} })
  end
end