class PersonController < ApplicationController
  def auto_complete
    term = "%#{params[:term]}%"
    @people = Person.where('name LIKE ? OR yomigana LIKE ? OR other_name LIKE ?', term, term, term)
    render json: @people.to_json
  end

  def auto_complete_twitter
    term = "#{params[:term]}%"
    @people = Person.where('twitter LIKE ?', term)
    render json: @people.to_json
  end
end
