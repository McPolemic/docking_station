require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  def setup
    @project = Project.new(name: "NewService")
  end

  test "tag" do
    commit = "123456"

    expected = "NewService:123456"

    assert_equal @project.tag_id(commit), expected
  end

  test "build_command_string" do
    commit = "123456"

    expected = "docker build -t NewService:123456 ."

    assert_equal @project.build_command_string(commit), expected
  end

  test "test_command_string" do
    commit = "8675309"
    @project.test_command = "test this"

    expected = "docker exec -it --rm NewService:8675309 test this"

    assert_equal @project.test_command_string(commit), expected
  end
end
