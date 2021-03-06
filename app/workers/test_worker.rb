class TestWorker
  include Sidekiq::Worker
  def perform(build_id)
    build = Build.find(build_id)
    project = build.project

    command = "docker run -dP #{project.tag_id(build.commit)}"

    build.test_output = "Starting up server...\n"
    build.save

    status, container_id = run_command( command ) {}

    if status == false
      build.test_output = "Running server failed"
      build.save
      return
    end

    build.test_output = "Testing...\n"; build.save

    command = "docker exec -it #{container_id} #{project.test_command}"
    build.test_status, build.test_output = run_command(command) { |line| build.test_output << line; logger.debug(line); build.save }
    if build.test_status == false
      build.test_output << "Tests for #{project.name}-#{build.commit} failed"
      build.save
    end
  end

  def run_command(command)
    output = []

    IO.popen(command) do |block|
      block.each do |line|
        yield line
        output << line
      end
    end

    status = $? == 0

    [status, output.join("\n").strip]
  end
end
