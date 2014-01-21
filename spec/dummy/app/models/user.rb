class User < ActiveRecord::Base
  neutral_voter

  def self.authenticate(username, password)
    User.find_by(username: username, password: password)
  end
end
