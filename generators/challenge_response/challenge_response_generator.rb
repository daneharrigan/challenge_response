class ChallengeResponseGenerator < Rails::Generator::Base
  def manifest
    # create the migrate folder
    FileUtils.mkdir "#{RAILS_ROOT}/db/migrate" unless File.directory? "#{RAILS_ROOT}/db/migrate"
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')

    # add migration file
    record do |m|
      m.file 'challenge_response_migration.rb', "db/migrate/#{timestamp}_challenge_response_migration.rb"
      m.template 'challenge_questions.rb', "vendor/plugins/challenge_response/challenge_questions.yml"
    end
  end
end