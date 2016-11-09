class Venue < ActiveRecord::Base
  class Saver < Struct.new(:venue, :params, :failure)

    def check_to_save
      venue.attributes = params[:venue] || {}
      check_valid?
    end

    def save_venue
      venue.save
    end

    private
    def evil_robot?
      if params[:trap_field].present?
        self.failure ||= {:error => "<h3>Evil Robot</h3> We didn't save this event because we think you're an evil robot. If you're really not an evil robot, look at the form instructions more carefully. If this doesn't work please file a bug report and let us know."}
      end
    end

    def collect_error_message
      self.failure = venue.errors.messages
    end

    def check_valid?
      return false if evil_robot?
      unless venue.valid?
        collect_error_message
        return false
      else
        return true
      end
    end

  end
end

