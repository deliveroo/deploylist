require 'platform-api'

class SlugInfoFetcher
  def initialize(deploy_id, slug_id)
    @deploy_id = deploy_id
    @slug_id = slug_id
  end

  def fetch_and_update!
    slug = client.slug.info(ENV['HEROKU_APP'], @slug_id)

    Deploy.update(@deploy_id, artifact_size: slug['size']) if slug
  end

  private
  def client
    @client ||= PlatformAPI.connect_oauth ENV.fetch('HEROKU_TOKEN')
  end
end
