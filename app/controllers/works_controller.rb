class WorksController < ApplicationController
  def auto_complete
    term = "%#{params[:term]}%"
    @works = Work.where('name LIKE ? OR yomigana LIKE ?', term, term)
    render json: @works.to_json
  end
end
