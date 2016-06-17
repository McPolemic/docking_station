require 'tempfile'

class BuildWorker
  include Sidekiq::Worker
  def perform(build_id)
    build = Build.find(build_id)
    project = build.project

    Dir.mktmpdir do |temp_dir|
      logger.info "Running 'git clone #{project.url} #{temp_dir} && cd #{temp_dir} && #{project.build_command_string(build.commit)}'"
      build.build_status, build.build_output = run_command( "git clone #{project.url} #{temp_dir} && cd #{temp_dir} && #{project.build_command_string(build.commit)}" )
      build.save
    end
  end

  def run_command(command)
    output = %x[ #{command} ]
    status = $? == 0

    [status, output]
  end
end
