json.array!(@builds) do |build|
  json.extract! build, :id, :name, :commit, :project_id, :build_status, :build_output, :test_status, :test_output, :deployment_status, :deployment_output
  json.url build_url(build, format: :json)
end
