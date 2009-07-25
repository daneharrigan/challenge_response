class Challenge < ActiveRecord::Base
  validates_presence_of :question
  validates_length_of :question, :in => 10..50
  validates_format_of :question, :with => /\A[\w\d\ \?\+-]+\z/

  validates_presence_of :answer
  validates_length_of :answer, :in => 1..20
  validates_format_of :answer, :with => /\A[\w\d]+\z/

  has_many :challenged_sessions

  def answer?(value)
    if value.match /\A[\w\d]+\z/
      (answer == value.to_s)
    else
      false
    end
  end

  def self.valid?(id)
    if id.to_s.match /\A[\d]+\z/
      begin
        challenge = find(id)
      rescue
        challenge = nil
      end
      return !challenge.nil?
    else
      return false
    end
  end
end
