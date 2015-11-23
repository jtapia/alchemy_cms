class ScheduleCmsPagePublish

  include Sidekiq::Worker

  def perform(page_id)
    page = Alchemy::Page.find(page_id)
    puts "Publishing: #{page.name}"
    page.publish!
    page.update_attributes(job_id: nil, scheduled_publish_time: nil) 
  end
end

