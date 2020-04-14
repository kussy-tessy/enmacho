# require './app/models/KigurumiForm'

class KigurumisController < ApplicationController
  def index
    @params = params
    if request.query_parameters.values.filter(&:present?).any?
      @kigurumis = Kigurumi.search(params)
    end
    render 'index'
  end

  def new
    kigurumi = Kigurumi.new
    @form = KigurumiForm.new(kigurumi)
    @form.owner_name = params[:name]
    @form.owner_twitter = params[:twitter]
    @url = kigurumis_path
    @method = 'post'
    render 'edit'
  end

  def show
    @kigurumi = Kigurumi.find(params[:id])
  end

  def edit
    kigurumi = Kigurumi.find(params[:id])
    @form = KigurumiForm.new(kigurumi)
    @url = kigurumi_path(kigurumi)
    @method = 'put'
    render 'edit'
  end

  def create
    kigurumi = Kigurumi.new
    @form = KigurumiForm.new(kigurumi)
    @form.update(sent_params)
    kigurumi = @form.save
    if kigurumi
      redirect_to kigurumi_path(kigurumi)
    else
      @url = kigurumis_path
      @method = 'post'
      @form.attributes = sent_params
      render 'edit'
    end
  end

  def update
    kigurumi = Kigurumi.find(sent_params[:id]) 
    @form = KigurumiForm.new(kigurumi)
    @form.update(sent_params)
    kigurumi = @form.save
    if kigurumi
      redirect_to kigurumi_path(kigurumi)
    else
      @url = kigurumi_path(kigurumi)
      @method = 'put'
      @form.attributes = sent_params
      render 'edit'
    end
  end

  private
    def sent_params
      params.require(:kigurumi_form).permit(:id, :owner_name, :owner_twitter, :character_name, :is_original, :work_name, :factory_id, :base_id, :customizer_name, :customizer_twitter, :previous_owner_name, :previous_owner_twitter, :show_year, :remarks, :hair_color, :hair_length, :mouth_open, kigurumi_images: [])
    end
end