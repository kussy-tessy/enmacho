class PeopleController < ApplicationController
  def index
    @params = params
    @kigurumis = Kigurumi.search(params)
    render 'index'
  end

  def new
    @url = people_path
    @person = Person.new()
    @method = 'post'
    render 'edit'
  end

  def show
    @kigurumi = Kigurumi.find(params[:id])
  end

  def edit
    @kigurumi = Kigurumi.find(params[:id])
    @url = kigurumi_path(@kigurumi)
    @method = 'put'
    render 'edit'
  end

  def create
    self.update
  end

  def update
    service = KigurumisSaveService.new(sent_params)
    kigurumi = service.save
    redirect_to kigurumi_path(kigurumi)
  end

  def auto_complete
    term = "%#{params[:term]}%"
    @people = Person.where('name LIKE ? OR yomigana LIKE ? OR other_name LIKE ?', term, term, term)
    render json: @people.to_json(methods: [:name_with_twitter])
  end

  def auto_complete_twitter
    term = "#{params[:term]}%"
    @people = Person.where('twitter LIKE ?', term)
    render json: @people.to_json(methods: [:name_with_twitter, :twitter])
  end

  def kigurumis
    twitter = params[:twitter].present? ? params[:twitter] : nil
    name = params[:name]
    @person = Person.find_or_initialize_by(twitter: twitter, name: name)
    render json: @person.kigurumis.to_json(include: [:character])
  end

  private
    def sent_params
      params.permit(:id, :person_name, :twitter, :character_name, :work_name, :factory_id, :base_id, :customizer_name, :customizer_twitter, :previous_owner_name, :previous_owner_twitter, :remarks, kigurumi_images: [])
    end
end
