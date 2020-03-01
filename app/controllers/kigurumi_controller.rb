class KigurumiController < ApplicationController
  def index
    render 'index'
  end

  def search
    @kigurumis = Kigurumi.search(params)
  end

  def new
    @method = 'create'
    render 'edit'
  end

  def create
  end

  def show
    @kigurumi = Kigurumi.find(params[:id])
  end

  def edit
    @method = 'create'
    render 'edit'
  end

  def create
    twitter = sent_params[:twitter].presence || nil
    person = Person.find_or_create_by!(name: sent_params[:person_name], twitter: twitter)

    work_name = sent_params[:work_name].presence || 'オリジナル'
    work = Work.find_or_create_by!(name: work_name) 
    character = work.characters.find_or_create_by!(name: sent_params[:character_name])
    factory = sent_params[:factory_id].present? ? Factory.find(sent_params[:factory_id]) : nil
    base = sent_params[:base_id].present? ? Base.find(sent_params[:base_id]) : nil
    kigurumi = person.kigurumis.create!(character: character, factory: factory)
    kigurumi_images = sent_params['kigurumi_images']
    kigurumi.kigurumi_images.destroy_all
    kigurumi.kigurumi_images.create!(kigurumi_images.map{|image| {url: image} })
    render 'edit'
  end

  private
    def sent_params
      params.permit(:person_name, :twitter, :character_name, :work_name, :factory_id, :base_id, :previous_person_name, kigurumi_images: [])
    end
end
