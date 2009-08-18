module ChallengeResponseHelper
  def challenge_answer_tag(options = {})
    options[:name] = 'challenge_answer'
    text_field_tag('challenge_answer', nil, options)
  end

  def challenge_question
    @challenge.question
  end
end