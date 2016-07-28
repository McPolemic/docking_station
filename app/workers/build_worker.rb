require 'tempfile'

class BuildWorker
  include Sidekiq::Worker
  def perform(build_id)
    build = Build.find(build_id)
    project = build.project

    Dir.mktmpdir do |temp_dir|
      command = project.build_command_string(build.commit)
      logger.info "Running '#{command}'"

      build.build_output = "Building..."
      build.save

      build.build_status, _ = run_command( command ) { |line| build.build_output << line; build.save }
      build.save
    end

    TestWorker.perform_async(build_id)
  end

  def run_command(command, &block)
    output = []

    IO.popen(command) do |block|
      block.each do |line|
        yield line
        output << line
      end
    end

    status = $? == 0

    [status, output]
  end
end
