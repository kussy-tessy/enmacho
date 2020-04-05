# require './app/models/KigurumiForm'

class KigurumisController < ApplicationController
  def index
    @params = params
    @kigurumis = Kigurumi.search(params)
    render 'index'
  end

  def new
    @url = kigurumis_path
    @kigurumi = Kigurumi.new()
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
    self.update
  end

  def update
    # service = KigurumisSaveService.new(sent_params)
    kigurumi = Kigurumi.find(sent_params[:id])
    @form = KigurumiForm.new(kigurumi)
    @form.update(sent_params)
    if @form.save
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
      params.require(:kigurumi_form).permit(:id, :owner_name, :owner_twitter, :character_name, :work_name, :factory_id, :base_id, :customizer_name, :customizer_twitter, :previous_owner_name, :previous_owner_twitter, :show_year, :remarks, :kigurumi_images)
    end
end