class KigurumiController < ApplicationController
  def index
    render 'index'
  end

  def search
    characters = nil
    factory = nil
    base = nil    
    if params[:character_name].present?
      characters = Character.where(name: params[:character_name])
    elsif params[:work_name].present?
      work = params[:work_name]
      characters = Work.where(work: work)
    end
    if params[:factory_id].present?
      factory = Factory.find(params[:factory_id])
    end
    if params[:base_id].present?
      base = Base.find(params[:base_id])
    end
    
    @kigurumis = Kigurumi.where(character: characters).where(factory: factory).where(base: base)
  end

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

    work = Work.find_or_create_by!(name: sent_params[:work_name])
    character = work.characters.find_or_create_by!(name: sent_params[:character_name])
    factory = Factory.find(sent_params[:factory_id])
    if sent_params[:base_id].present?
      base = Base.find(sent_params[:base_id])
    else
      base = nil
    end  
    kigurumi = person.kigurumis.create!(character: character, factory: factory)
    render json: Character.last
  end

  private
    def sent_params
      params.permit(:person_name, :twitter, :character_name, :work_name, :factory_id, :base_id, :previous_person_name)
    end
end
