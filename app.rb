require ("sinatra")
require ("sinatra/reloader")
require ("sinatra/activerecord")
also_reload('lib/**/*.rb')
require('./lib/survey')
require('./lib/question')
require('./lib/answer')
require ('pg')


get('/') do
  @surveys = Survey.all()
  erb(:index)
end

get("/surveys/new") do
  erb(:survey_form)
end

post('/surveys/new') do
  @survey = Survey.create({:title => params.fetch("title")})

  erb(:question_form)
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i())

  erb(:survey)
end

patch("/surveys/:id") do
  @survey = Survey.find(params.fetch("id").to_i())
  @survey.update({:title => params.fetch("title")})

  redirect('/')
end

post('/surveys/:id/questions')do
  @question = Question.create({:question => params.fetch("question"),:survey_id => params.fetch("id").to_i()})
  @survey = Survey.find(params.fetch("id").to_i())
  erb(:answer_form)
end

get("/surveys/questions/:id")do
  @question = Question.find(params.fetch("id").to_i())
  @survey = Survey.find(@question.survey_id().to_i())
  erb(:question_form)
end

patch("/surveys/questions/:id") do
  @question = Question.find(params.fetch("id").to_i())
  @question.answers().create({:answer => params.fetch("answer"), :question_id => params.fetch("id").to_i()})

  @survey = Survey.find(@question.survey_id().to_i())
  erb(:answer_form)
end

get('/questions/:id') do
  @question = Question.find(params.fetch("id").to_i())
  erb(:question)
end

patch ('/questions/:id') do
  @question = Question.find(params.fetch("id").to_i())
  @question.update({:question => params.fetch("question")})

  redirect("/questions/#{@question.id().to_i()}")
end

get ('/answers/:id') do
  @answer = Answer.find(params.fetch('id').to_i())

  erb(:answer)
end

patch ('/answers/:id') do
  @answer = Answer.find(params.fetch('id').to_i())
  @answer.update({:answer => params.fetch('answer')})

  redirect("/questions/#{@answer.question_id().to_i()}")
end

delete ('/surveys/:id') do
  survey = Survey.find(params.fetch("id").to_i())
  survey.delete()

  redirect('/')
end

delete ('/questions/:id') do
  question =  Question.find(params.fetch("id").to_i())
  survey_id = question.survey_id()
  question.delete()

  redirect("/surveys/#{survey_id}")
end

get('/surveys/:id/questions')do
  @survey = Survey.find(params.fetch("id").to_i())

  erb(:question_form)
end


delete ('/answers/:id') do
  answer =  Answer.find(params.fetch("id").to_i())
  question_id = answer.question_id()
  answer.delete()

  redirect("/questions/#{question_id}")
end


get ('/takers/surveys') do
  @surveys = Survey.all()
  erb(:take_survey)
end

get ('/takers/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i())

  erb(:take_survey_form)
end
