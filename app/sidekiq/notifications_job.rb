class EventsJob
  include Sidekiq::Job
  include DatabaseConnection

  def perform(name, count)
    user = User.find(id)
    ActionCable.server.broadcast "notifications:#{user.id}", {html:
      "<div class='alert alert-warning alert-block text-center'>
          <i class='fa fa-circle-o-notch fa-spin'></i>
          Searching your gmail for receipts now (it might take a minute if there are many).
      </div>"
      }
    Scraper.process_emails(user, date, token)
    ActionCable.server.broadcast "notifications:#{user.id}", {html:
      "<div class='alert alert-success alert-block text-center'>
          Search complete!
      </div>"
        }
  end
end
