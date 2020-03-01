class FactoriesController < ApplicationController
  def bases
    @bases = Factory.find(params[:factory_id]).bases
    render json: @bases.to_json
  end
end
