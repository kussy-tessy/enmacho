class CharacterController < ApplicationController
  def auto_complete
    term = "%#{params[:term]}%"
    @characters = Character.where('name LIKE ? OR yomigana LIKE ?', term, term)
    render json: @characters.to_json(include: [:work])
  end
end
