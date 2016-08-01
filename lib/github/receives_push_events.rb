require 'octokit'

module Github
  COMMIT_STATUS_STATES = %i{pending success failure error}

  # Set a status for a given commit
  class BuildStatus
    def initialize(organization:, repo:, commit:)
      @organization = organization
      @repo = repo
      @commit = commit
    end

    def update_status(state, target_url:nil, description:nil, context:nil)
      raise "State must be one of #{COMMIT_STATUS_STATES}" unless COMMIT_STATUS_STATES.include?(state)
      p "Octokit.create_status(\"#{@organization}/#{@repo}\", #{@commit}, #{state.to_s}, context: #{context}, target_url: #{target_url}, description: #{description})"
      Octokit.create_status("#{@organization}/#{@repo}", @commit, state.to_s, context: context, target_url: target_url, description: description)
    end
  end
end
