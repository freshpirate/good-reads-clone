class SendMailWorker
  include Sidekiq::Worker

  def perform(user_id)
    # Do something
    UserMailer.new_user(User.find(user_id)).deliver
    puts "*"*100
    puts "Mail delivered!"
  end
end
