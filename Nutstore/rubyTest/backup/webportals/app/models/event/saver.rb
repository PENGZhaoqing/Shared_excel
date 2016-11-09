class Event < ActiveRecord::Base
  class Saver < Struct.new(:event, :params, :failure)

    def check_to_save
      event.attributes = params[:event] || {}
      event.venue = find_or_initialize_venue
      event.start_time = [params[:start_date], params[:start_time]].join(' ')
      event.end_time = [params[:end_date], params[:end_time]].join(' ')
      # event.tags.reload # Reload the #tags association because its members may have been modified when #tag_list was set above.
      check_valid?
    end

    def has_new_venue?
      return unless event.venue
      event.venue.previous_changes["id"] == [nil, event.venue.id] && params[:venue_name].present?
    end

    def preview?
      return true if params[:preview]
      return false
    end

    def save_event
      event.save
    end

    private

    def find_or_initialize_venue
      if params[:event] && params[:event][:venue_id].present?
        Venue.find(params[:event][:venue_id])
      else
        Venue.find_or_initialize_by(title: params[:venue_name])
      end
    end

    # 按照顺序返回结果,如果是spam直接返回false,然后再检查是否preview
    # 如果是preview,直接返回false
    # def attempt_save?
    #   !spam? && !preview? && event.save
    # end

    def spam?
      evil_robot? || too_many_links?
    end

    def evil_robot?
      if params[:trap_field].present?
        self.failure ||= {:error => "<h3>Evil Robot</h3> We didn't save this event because we think you're an evil robot. If you're really not an evil robot, look at the form instructions more carefully. If this doesn't work please file a bug report and let us know."}
      end
    end

    def too_many_links?
      return false if !links_added?
      if event.description.present? && link_count(event.description) > 3
        self.failure ||= {:error =>"We allow a maximum of 3 links in a description. You have too many links."}
      end
    end

    def links_added?
      link_count(event.description) > link_count(event.description_was)
    end

    def link_count(text)
      return 0 if text.blank?
      text.scan(/https?:\/\//i).size
    end

    def collect_error_message
      self.failure = event.errors.messages
    end

    def check_valid?
      return false if spam?
      unless event.valid?
        collect_error_message
        return false
      else
        return true
      end
    end

  end
end

