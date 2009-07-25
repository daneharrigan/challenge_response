def challenge_response
  @challenge_token = form_authenticity_token
  new_challenge = true

  # check for current challenge
  current_challenge = ChallengedSession.find(:first, :conditions => ['session = ?',@challenge_token])

  if current_challenge
    @challenge = current_challenge.challenge
    if params[:challenge_answer] and @challenge.answer? params[:challenge_answer]
      new_challenge = false
      @challenge_successful = true
    end

    current_challenge.destroy
  end

  create_challenge if new_challenge
end

def create_challenge
  challenged_session = ChallengedSession.new
  challenged_session.session = @challenge_token
  challenged_session.challenge_id = Challenge.find(:first, :offset => rand(Challenge.count)).id

  challenged_session.save!

  @challenge = challenged_session.challenge
  @challenge_successful = false
end

def challenge_question
  @challenge.question
end

def challenge_successful?
  @challenge_successful
end

def challenge_answer(options = {})
  values[:name] = 'challenge_answer'
  text_field_tag('challenge_answer', nil, options)
end
