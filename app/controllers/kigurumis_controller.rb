require './app/services/kigurumis_save_service'

class KigurumisController < ApplicationController
  def index
    @params = params
    @kigurumis = Kigurumi.search(params)
    render 'index'
  end

  def search
    @kigurumis = Kigurumi.search(params)
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

  private
    def sent_params
      params.permit(:id, :person_name, :twitter, :character_name, :work_name, :factory_id, :base_id, :customizer_name, :customizer_twitter, :previous_owner_name, :previous_owner_twitter, :remarks, kigurumi_images: [])
    end
end
