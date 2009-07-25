require 'test_helper'

class ChallengeResponseTest < ActiveSupport::TestCase
  def setup
    @session = 'f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b8'
  end

  ############################
  # cant save challenge tests
  ############################
  def test_cant_save_empty_challenge
    challenge = Challenge.new
    assert !challenge.save
  end

  def test_cant_save_empty_question_challenge
    challenge = Challenge.new({ :answer => 'A' })
    assert !challenge.save
  end

  def test_cant_save_empty_answer_challenge
    challenge = Challenge.new({ :question => 'What letter comes before B?' })
    assert !challenge.save
  end

  def test_cant_save_invalid_question_challenge
    challenge = Challenge.new({ :question => ';;; exit; exit; exit; %> closing ERB <% puts ENV', :answer => 'A' })
    assert !challenge.save
  end

  def test_cant_save_invalid_answer_challenge
    challenge = Challenge.new({ :question => 'What letter comes before B?', :answer => ';;; exit; exit; exit; %> closing ERB <% puts ENV' })
    assert !challenge.save
  end

  def test_cant_save_invalid_characters_challenge
    challenge = Challenge.new({ :question => '!@#$%^&*()_[]{}\\||//..<>,', :answer => '!@#$%^&*()_[]{}\\||//..<>,' })
    assert !challenge.save
  end

  ############################
  # can save challenge tests
  ############################
  def test_can_save_before_letter_challenge
    challenge = Challenge.new({ :question => 'What letter comes before B?', :answer => 'A' })
    assert challenge.save
  end

  def test_can_save_after_letter_challenge
    challenge = Challenge.new({ :question => 'What letter comes after B?', :answer => 'C' })
    assert challenge.save
  end

  def test_can_save_addition_math_challenge
    challenge = Challenge.new({ :question => 'What does 3 + 2 equal?', :answer => '5' })
    assert challenge.save
  end

  def test_can_save_subtraction_math_challenge
    challenge = Challenge.new({ :question => 'What does 3 - 2 equal?', :answer => '1' })
    assert challenge.save
  end

  ############################
  # cant save session tests
  ############################

  def test_session_and_challenge_empty
    challenged_session = ChallengedSession.new
    assert !challenged_session.save
  end

  def test_session_id_is_nil
    challenged_session = ChallengedSession.new({ :challenge_id => 1 })
    assert !challenged_session.save
  end

  def test_challenge_id_is_nil
    challenged_session = ChallengedSession.new({ :session => @session })
    assert !challenged_session.save
  end

  def test_session_id_less_than_44_characters
    challenged_session = ChallengedSession.new({ :challenge_id => 1, :session => 'f86d081884c7d659a2feaa' }) # 22 characters
    assert !challenged_session.save
  end

  def test_challenge_id_is_invalid
    challenged_session = ChallengedSession.new({ :challenge_id => (Challenge.find(:last).id+1), :session => @session })
    assert !challenged_session.save
  end

  ############################
  # can save session tests
  ############################

  def test_create_valid_challenged_session
    challenge = Challenge.new({ :question => 'What does 1 + 1 equal?', :answer => '2' })
    challenge.save

    challenged_session = ChallengedSession.new({ :challenge_id => challenge.id, :session => @session })
    assert challenged_session.save
  end

  ############################
  # additional tests
  ############################

  def test_challenge_is_readable
    challenge = Challenge.new({ :question => 'What does 1 + 1 equal?', :answer => '2' })
    challenge.save

    challenged_session = ChallengedSession.new({ :challenge_id => challenge.id, :session => @session })
    challenged_session.save

    assert !challenged_session.challenge.nil?
  end

  def test_challenge_correct_answer
    challenge = Challenge.new({ :question => 'What does 1 + 1 equal?', :answer => '2' })
    assert challenge.answer? challenge.answer
  end

  def test_challenge_wrong_answer
    challenge = Challenge.new({ :question => 'What does 1 + 1 equal?', :answer => '2' })
    assert !challenge.answer?('12')
  end
end
