class ChallengedSession < ActiveRecord::Base
  validates_presence_of :challenge_id
  validates_numericality_of :challenge_id, :greater_than => 0
  validate :valid_challenge_id

  validates_presence_of :session
  validates_length_of :session, :is => 44
  validates_format_of :session, :with => /\A[\w\d\/\+=]+\z/

  belongs_to :challenge

  def self.sweep(time_ago = nil)
    time = case time_ago
      when /^(\d+)m$/ then Time.now - $1.to_i.minute
      when /^(\d+)h$/ then Time.now - $1.to_i.hour
      when /^(\d+)d$/ then Time.now - $1.to_i.day
      else Time.now - 1.hour
    end
    self.delete_all "created_at < '#{time.to_s(:db)}'"
  end

  protected
  def valid_challenge_id
    errors.add(:challenge_id, 'Invalid challenge ID') unless !challenge_id.nil? and Challenge.valid? challenge_id
  end
end