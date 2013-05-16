class Url < ActiveRecord::Base
  belongs_to :user
  validates :original_url, :format => {:with => /https?:\/\/\w+.\w{2,}/, :message => "This is not an url"}

  def shorten
  	SecureRandom.hex(2) + '.' + (0..1).map{97.+(rand(26)).chr}.join 
  end


	def self.create_short(original, user_id)
  	current = Url.new(original_url: original, user_id: user_id)
		current.save!
		short_url = current.shorten
		current.update_attributes(:short_url => short_url)
		return current
  end
end
