# require 'sidekiq-scheduler'
class ArchiveWorker 
  include Sidekiq::Worker
  def perform(order_details_update={})
    if order_details_update.keys[0]=="status"
      Order.where("created_at >= ? and created_at <= ?",order_details_update["status"]["from_date"],order_details_update["status"]["to_date"]).update_all(status: "completed")
    else 
      Order.where("created_at <= ?", Date.today()-7).update_all(archive: true)#24 or less
      puts "\nworks\n"
    end
  end
end