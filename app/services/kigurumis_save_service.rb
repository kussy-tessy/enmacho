class KigurumisSaveService
  def initialize(params)
    @params = params
  end

  def validate
    @error_messages = {}
    @error_messages[:person_name] = '苦し紛れ'
    return @error_messages
  end

  def save
    @kigurumi = @params[:id].present? ? Kigurumi.find(@params[:id]) : Kigurumi.new
    twitter = @params[:twitter].presence || nil
    owner = Person.find_or_create_by!(name: @params[:person_name], twitter: twitter)
    
    previous_owner_twitter = @params[:previous_owner_twitter].presence || nil
    previous_owner = Person.find_or_create_by!(name: @params[:previous_owner_name], twitter: previous_owner_twitter)

    customizer_twitter = @params[:customizer_twitter].presence || nil
    customizer = Person.find_or_create_by!(name: @params[:customizer_name], twitter: @params[:customizer_twitter])

    work_name = @params[:work_name].presence || 'オリジナル'
    work = Work.find_or_create_by!(name: work_name)
    character = work.characters.find_or_create_by!(name: @params[:character_name])
    factory = @params[:factory_id].present? ? Factory.find(@params[:factory_id]) : nil
    @kigurumi.owner = owner
    @kigurumi.previous_owner = previous_owner if @params[:previous_owner_name].present?
    @kigurumi.customizer = customizer if @params[:customizer_name].present?
    @kigurumi.character = character
    @kigurumi.factory = factory
    @kigurumi.remarks = @params[:remarks].presence || nil
    @kigurumi.show_year = @params[:show_year].presence || nil
    @kigurumi.save!
    kigurumi_images = @params['kigurumi_images']
    @kigurumi.kigurumi_images.destroy_all
    @kigurumi.kigurumi_images.create!(kigurumi_images.map{|image| {url: image} })

    return @kigurumi
  end
end