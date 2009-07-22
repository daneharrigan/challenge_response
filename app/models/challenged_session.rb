class ChallengedSession < ActiveRecord::Base
  validates_presence_of :challenge_id
  validates_numericality_of :challenge_id, :greater_than => 0
  validate Proc.new { |c| c.challenge_id <= Challenge.count }

  validates_presence_of :session
  validates_length_of :session, :is => 44
  validates_format_of :session, :with => /\A[\w\d\+=]+\z/

  belongs_to :challenge
end
