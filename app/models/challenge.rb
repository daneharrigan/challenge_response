class Challenge < ActiveRecord::Base
  has_many :challenged_sessions
end
