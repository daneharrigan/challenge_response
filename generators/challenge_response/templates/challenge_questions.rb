<%
question_counter = 1
questions_asked = []

# simple math questions

###################################
# addition questions
###################################

total_questions = rand(40)+10 # 10-50 questions
questions_created = 0

# addition questions
while total_questions > questions_created do
  num_1 = rand(total_questions)
  num_2 = rand(total_questions)

  # define question/answer
  question = "What does #{num_1} + #{num_2} equal?"
  answer = num_1 + num_2

  # check if question has already been asked
  unless questions_asked.include? question
%>
<%=question_counter%>:
  question: <%=question%>
  answer: <%=answer%>
<%
    questions_asked[questions_asked.length] = question
    question_counter += 1
    questions_created += 1
  end
end


###################################
# subtraction questions
###################################

total_questions = rand(40)+10 # 10-50 questions
questions_created = 0

while total_questions > questions_created do
  num_1 = rand(total_questions)
  num_2 = rand(total_questions)
  if num_2 > num_1
    while num_2 > num_1 do
      num_2 = rand(total_questions)
    end
  end

  # define question/answer
  question = "What does #{num_1} - #{num_2} equal?"
  answer = num_1 - num_2

  # check if question has already been asked
  unless questions_asked.include? question
%>
<%=question_counter%>:
  question: <%=question%>
  answer: <%=answer%>
<%
    questions_asked[questions_asked.length] = question
    question_counter += 1
    questions_created += 1
  end
end

# alphabet

###################################
# what comes after A-Z
###################################

total_questions = rand(24)+1 # 1-25 questions. nothing comes after Z
questions_created = 0

while total_questions > questions_created do
  letter_position = rand(24)+1
  letter = (65+letter_position).chr.to_s

  # define question/answer
  question = "What letter comes before #{letter}?"
  answer = (65+letter_position-1).chr.to_s

  # check if question has already been asked
  unless questions_asked.include? question
%>
<%=question_counter%>:
  question: <%=question%>
  answer: <%=answer%>
<%
    questions_asked[questions_asked.length] = question
    question_counter += 1
    questions_created += 1
  end
end

###################################
# what comes before A-Z
###################################

total_questions = rand(24)+2 # 2-26 questions. nothing comes before A
questions_created = 0

while total_questions > questions_created do
  letter_position = rand(24)+1
  letter = (65+letter_position).chr.to_s

  # define question/answer
  question = "What letter comes after #{letter}?"
  answer = letter.next

  # check if question has already been asked
  unless questions_asked.include? question
%>
<%=question_counter%>:
  question: <%=question%>
  answer: <%=answer%>
<%
    questions_asked[questions_asked.length] = question
    question_counter += 1
    questions_created += 1
  end
end
%>