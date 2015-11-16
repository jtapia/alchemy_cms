class ScheduleCmsPagePublish

  include Sidekiq::Worker

  def perform(page_id)
    page = Alchemy::Page.find(page_id)
    puts "Publishing: #{page.name}"
    page.publish!

  end
end

