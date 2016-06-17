json.array!(@projects) do |project|
  json.extract! project, :id, :name, :project_url, :environment, :test_command, :deploy_command
  json.url project_url(project, format: :json)
end
