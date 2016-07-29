class Build < ActiveRecord::Base
  belongs_to :project

  def clear!
    self.build_output = ""
    self.build_status = false
    self.test_output = ""
    self.test_status = false
    save
  end
end
