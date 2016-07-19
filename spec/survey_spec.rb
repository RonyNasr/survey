require ("spec_helper")

describe(Survey) do
  it "contains many quesitons" do
    survey = Survey.create({:title => "demo survey"})
    question1 = Question.create({:question => "q1", :survey_id => survey.id()})
    question2 = Question.create({:question => "q2", :survey_id => survey.id()})

    expect(survey.questions()).to(eq([question1,question2]))
  end

  describe('#capitalize_title') do
    it "capitalizes the title of a survey" do
      survey = Survey.create({:title => "demo survey"})
      expect(survey.title()).to (eq("Demo survey"))
    end
  end
end
