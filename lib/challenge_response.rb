def challenge_response
  @challenge_token = form_authenticity_token
  new_challenge = true

  # check for current challenge
  current_challenge = ChallengedSession.find(:first, :conditions => ['session = ?',@challenge_token])

  if current_challenge
    @challenge = current_challenge.challenge
    if params[:challenge_answer] and params[:challenge_answer] == @challenge.answer
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
  challenged_session.challenge_id = rand(Challenge.count)+1
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