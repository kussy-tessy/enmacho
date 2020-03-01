class KigurumiImage < ApplicationRecord
  belongs_to :kigurumi

  def tweet_id
    self.url.match(/\d+$/){|match| match} 
  end
end
