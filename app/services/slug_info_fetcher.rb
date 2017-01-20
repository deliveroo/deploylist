require 'platform-api'

class SlugInfoFetcher
  def initialize(deploy_id, slug_id)
    @deploy_id = deploy_id
    @slug_id = slug_id
  end

  def fetch_and_update!
    slug = client.slug.info(ENV['HEROKU_APP'], @slug_id)

    if slug
      Deploy.update(@deploy_id, artifact_size: slug['size'])
      MetricsRecorder.instance.track('Artifact Size', deploy.artifact_size, at: deploy.created_at)
    end
  end

  private
  def deploy
    @deploy ||= Deploy.find(@deploy_id)
  end

  def client
    @client ||= PlatformAPI.connect_oauth ENV.fetch('HEROKU_TOKEN')
  end
end
