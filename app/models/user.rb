class User < ActiveRecord::Base
  

  def self.authenticate?(email, password)
  	@user = User.find_by_email(email)
  	if @user.password == password.reverse
  		return true
  	else
      false
    end
  end

end
