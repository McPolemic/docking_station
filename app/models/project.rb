class Project < ActiveRecord::Base
  has_many :builds, dependent: :destroy

  def tag_id(commit)
    "#{name}:#{commit}"
  end
  
  def build_command_string(commit)
    "docker build -t #{tag_id(commit)} ."
  end
end
