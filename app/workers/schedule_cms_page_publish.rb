class ScheduleCmsPagePublish

  include Sidekiq::Worker

  def test_execution(page_id, year, month, day, hours, minutes)
    page = Alchemy::Page.find(page_id)
    page.publish!
  end
  
  def perform(page_id, year, month, day, hours, minutes)
    binding.pry
    page = Alchemy::Page.find(page_id)
    Alchemy.page.publish!(page)
  end
end

