require 'test_helper'

class BuildTest < ActiveSupport::TestCase
  test "clearing clears build and test information" do
    subject = Build.create(name: 'Test Build',
                           build_output: "We're built",
                           build_status: true,
                           test_output: "And we're tested!",
                           test_status: true)

    subject.clear!

    assert_equal(subject.build_output, "")
    assert_equal(subject.build_status, false)
    assert_equal(subject.test_output, "")
    assert_equal(subject.test_status, false)
  end
end
