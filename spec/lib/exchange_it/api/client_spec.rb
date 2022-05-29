# frozen_string_literal: true

RSpec.describe ExchangeIt::Api::Client do
  let(:test_client) { described_class.new(ENV.fetch('LOKALISE_API_TOKEN', 'fake')) }
  let(:project_id) { '123.abc' }

  specify '#project' do
    body = JSON.dump(
      'project_id' => project_id,
      'project_type' => 'localization_files',
      'name' => 'My Web App',
      'description' => '',
      'created_at' => '2021-11-24 16:39:25 (Etc/UTC)'
    )

    stub_request(:get, "https://api.lokalise.com/api2/projects/#{project_id}")
      .with(headers: {
              'X-Api-Token' => '123abc'
            })
      .to_return(status: 200, body: body, headers: {})

    project = test_client.project project_id
    expect(project['project_id']).to eq(project_id)
    expect(WebMock).to have_requested(
      :get, "https://api.lokalise.com/api2/projects/#{project_id}"
    ).once
  end

  specify '#projects' do
    body = JSON.dump([
                       { name: 'Project 1' },
                       { name: 'Project 2' }
                     ])
    stub = stub_request(:get, 'https://api.lokalise.com/api2/projects')
           .with(query: { page: 2, limit: 3 })
           .to_return(status: 200, body: body)

    projects = test_client.projects page: 2, limit: 3
    expect(projects.length).to eq(2)
    expect(projects.first['name']).to eq('Project 1')

    expect(
      a_request(:get, 'https://api.lokalise.com/api2/projects')
        .with(query: { page: 2, limit: 3 })
    ).to have_been_made.at_least_once

    # WebMock.reset_executed_requests!
    expect(stub).to have_been_requested
  end

  describe '#create_project' do
    it 'creates project with proper params' do
      body = JSON.dump({ name: 'RSpec', description: 'Sample' })

      stub_request(:post, 'https://api.lokalise.com/api2/projects')
        .with(
          body: body,
          headers: {
            Accept: 'application/json',
            'X-Api-Token': test_client.token
          }
        )
        .to_return(status: 200, body: body, headers: {})

      project = test_client.create_project name: 'RSpec', description: 'Sample'
      expect(project['name']).to eq('RSpec')
    end

    it 'raises an error with invalid params' do
      stub_request(:post, 'https://api.lokalise.com/api2/projects')
        .to_raise(StandardError)

      expect { test_client.create_project({}) }.to raise_error(StandardError)
    end
  end
end
