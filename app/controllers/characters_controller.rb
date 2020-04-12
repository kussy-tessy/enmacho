class CharactersController < ApplicationController
  def update
    @character = Character.find(sent_params[:id])
    @character.yomigana = sent_params[:yomigana]
    @character.save!
    redirect_to random_edit_path_url
  end

  def auto_complete
    term = "%#{params[:term]}%"
    @characters = Character.where('name LIKE ? OR yomigana LIKE ?', term, term)
    render json: @characters.to_json(include: [:work], methods: [:name_with_work])
  end

  private
  def sent_params
    params.require(:character).permit(:id, :yomigana)
  end
end
