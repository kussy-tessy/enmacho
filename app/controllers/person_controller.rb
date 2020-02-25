class PersonController < ApplicationController
  def auto_complete
    term = "%#{params[:term]}%"
    @people = Person.where('name LIKE ? OR yomigana LIKE ? OR other_name LIKE ?', term, term, term)
    render json: @people.to_json(methods: [:name_with_twitter])
  end

  def auto_complete_twitter
    term = "#{params[:term]}%"
    @people = Person.where('twitter LIKE ?', term)
    render json: @people.to_json(methods: [:name_with_twitter])
  end

  def kigurumis
    twitter = params[:twitter].present? ? params[:twitter] : nil
    name = params[:name]
    @person = Person.find_or_initialize_by(twitter: twitter, name: name)
    render json: @person.kigurumis.to_json(include: [:character])
  end
end
