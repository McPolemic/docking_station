class Project < ActiveRecord::Base
  def tag_id(commit)
    "#{name}:#{commit}"
  end
  
  def build_command_string(commit)
    "docker build -t #{tag_id(commit)} ."
  end

  def test_command_string(commit)
    "docker exec -it --rm #{tag_id(commit)} #{test_command}"
  end
end
