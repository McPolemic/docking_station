require 'minitest/autorun'
require_relative '../../../lib/github/receives_push_events'

class TestBuildStatus < Minitest::Test
  def setup
    @subject = Github::BuildStatus.new(organization: "fake", repo: "fake", commit: '1234567890abcdef')
  end

  def test_status_must_be_a_valid_state
    exception_message_start = "State must be one of ["

    exc = assert_raises(RuntimeError) {
      Github::BuildStatus.new(organization: nil, repo: nil, commit: nil, state: :invalid)
    }

    assert(exc.message.start_with?(exception_message_start))
  end


end
