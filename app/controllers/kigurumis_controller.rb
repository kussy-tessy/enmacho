require './app/services/kigurumis_save_service'

class KigurumisController < ApplicationController
  def index
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
    service.save
    render 'index'
  end

  private
    def sent_params
      params.permit(:person_name, :twitter, :character_name, :work_name, :factory_id, :base_id, :previous_person_name, kigurumi_images: [])
    end
end
