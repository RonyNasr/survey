class Survey < ActiveRecord::Base
  has_many(:questions)
  before_save(:capitalize_title)

private

    def capitalize_title
      self.title = (title().capitalize())
    end
end
