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
    @person = Person.find(params[:id])
    render 'show'
  end

  def edit
    @person = Person.find(params[:id])
    @url = person_path(@person)
    @method = 'put'
    render 'edit'
  end

  def create
    self.update
  end

  def update
    @person = Person.find(sent_params[:id])
    if @person.update(sent_params)
      redirect_to person_path(@person)
    else
      render 'edit'
    end
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
      params.require(:person).permit(:id, :name, :twitter, :other_name, :yomigana, :prefecture_id, :home_prefecture_id, :birth_is_reliable, :birth_year, :birth_month, :birth_day, :remarks)
    end
end
