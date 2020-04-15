class WorksController < ApplicationController
  def update
    @work = Work.find(sent_params[:id])
    @work.yomigana = sent_params[:yomigana]
    @work.save!
    redirect_to random_edit_url
  end
  
  def auto_complete
    term = "%#{params[:term]}%"
    @works = Work.where('name LIKE ? OR yomigana LIKE ?', term, term)
    render json: @works.to_json
  end

  private
    def sent_params
      params.require(:work).permit(:id, :yomigana)
    end
end
