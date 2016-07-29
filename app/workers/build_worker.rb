require 'tempfile'

class BuildWorker
  include Sidekiq::Worker
  def perform(build_id)
    build = Build.find(build_id)
    project = build.project

    Dir.mktmpdir do |build_dir|
      Dir.chdir(build_dir) do

        # Cloning
        command = "git clone #{project.url} ."
        logger.info "Running `#{command}`"
        build.build_output = "Cloning...\n"; build.save
        build.build_status, _ = run_command( command ) { |line| build.build_output << line; build.save }
        if build.build_status == false
          build.build_output << "Cloning project #{project.name} failed"
          build.save
          return
        end

        # Building
        command = project.build_command_string(build.commit)
        logger.info "Running `#{command}`"
        build.build_output = "Building...\n"; build.save
        build.build_status, _ = run_command( command ) { |line| build.build_output << line; logger.debug(line); build.save }
        if build.build_status == false
          build.build_output << "Building project #{project.name}-#{build.commit} failed"
          build.save
          return
        end

      end
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
