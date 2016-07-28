class TestWorker
  include Sidekiq::Worker
  def perform(build_id)
    build = Build.find(build_id)
    project = build.project

    command = "docker run -dP #{project.tag_id(build.commit)}" #{project.test_command_string(build.commit)}"

    build.test_output = "Starting up server...\n"
    build.save

    status, container_id = run_command( command )

    if status == false
      build.test_output = "Running server failed"
      build.save
      return
    end

    build.test_output = "Testing...\n"; build.save

    command = "docker exec -it #{container_id} #{project.test_command}"
    build.test_status, build.test_output = run_command(command)
    build.save
  end

  def run_command(command)
    logger.info "Running '#{command}'"
    output = %x[ #{command} ]
    status = $? == 0

    [status, output.strip]
  end
end
