require 'yaml'

class ChallengeResponseMigration < ActiveRecord::Migration
  def self.up
    create_table :challenges do |t|
      t.string :question
      t.string :answer
      t.timestamps
    end

    create_table :challenged_sessions do |t|
      t.integer :challenge_id
      t.string :session
      t.timestamps
    end

    # load challenge questions
    challenge_questions = YAML::load_file("#{RAILS_ROOT}/vendor/plugins/challenge_response/challenge_questions.yml")

    # add questions to the challenges table
    challenge_questions.each_value { |c| Challenge.new({ :question => c['question'], :answer => c['answer'] }).save! }
  end

  def self.down
    drop_table :challenges
    drop_table :challenged_sessions
  end
end