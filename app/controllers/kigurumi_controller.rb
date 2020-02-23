class KigurumiController < ApplicationController
  def new
    @method = 'create'
    render 'edit'
  end

  def create
  end

  def edit
    @method = 'create'
    render 'edit'
  end

  def create
    twitter = sent_params[:twitter].present? ? sent_params[:twitter] : nil
    person = Person.find_or_create_by!(name: sent_params[:person_name], twitter: twitter)

    work = Work.find_or_create_by(name: sent_params[:work_name])
    character = work.characters.find_or_create_by(name: sent_params[:character_name])
    factory = Factory.find(sent_params[:factory_id])
    # base = Base.find(sent_params[:base_id])

    
    kigurumi = person.kigurumis.create!(character: character, factory: factory)
    render json: Character.last
  end

  private
    def sent_params
      params.permit(:person_name, :twitter, :character_name, :work_name, :factory_id, :base_id, :previous_person_name)
    end
end
