class Challenge < ActiveRecord::Base
  has_many :challenged_sessions

  def answer?(value)
    (answer == value.to_s)
  end
end
