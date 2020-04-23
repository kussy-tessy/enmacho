class KigurumiImage < ApplicationRecord
  before_save :chop_url

  belongs_to :kigurumi, touch: true

  def tweet_id
    self.url.match(/\d+$/){|match| match} 
  end

  private
    def chop_url
      self.url = self.url.split('?')[0]
    end
end
