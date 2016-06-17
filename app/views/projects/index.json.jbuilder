json.array!(@projects) do |project|
  json.extract! project, :id, :name, :url, :environment, :test_command, :deploy_command
  json.url project_url(project, format: :json)
end
