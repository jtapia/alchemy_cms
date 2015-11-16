class ScheduleCmsPagePublish
  include Sidekiq::Worker
  def perform(page_id)
    page = Alchemy::Page.find(page_id)
    Alchemy.page.publish!(page)
  end
end
