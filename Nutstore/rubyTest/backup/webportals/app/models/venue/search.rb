
class Venue < ActiveRecord::Base
  class Search < Struct.new(:tag, :query, :wifi, :all, :closed, :include_closed)

    # attributes 为实例化的时候传入的参数
    # 0> attributes
    # => {"controller"=>"calagator/venues", "action"=>"index"}

    def initialize attributes = {}
      # members=> [:tag, :query, :wifi, :all, :closed, :include_closed]
      members.each do |key|
        # 如果传入的是标准的参数,这一句有用
        send "#{key}=", attributes[key]
        # send "#{key}=", attributes[key] => nil
      end
    end

    def venues
      @venues ||= perform_search
    end

    def most_active_venues
      base.business.wifi_status.scope.order('events_count DESC').limit(10)
    end

    def newest_venues
      base.business.wifi_status.scope.order('created_at DESC').limit(10)
    end

    def results?
      query || tag || all
    end

    def failure_message
      @failure_message
    end

    def hard_failure?
      @hard_failure
    end

    protected

    def perform_search
      if query
        Venue.search(query, :include_closed=> include_closed, :wifi=> wifi)
      else
        base.business.wifi_status.search.scope
      end
    rescue ActiveRecord::StatementInvalid => e
      @failure_message = "There was an error completing your search."
      @hard_failure = true
      []
    end

    #non_duplicates 是lib/calagator/duplicates_checking的scope方法
    def base
      @scope = Venue.all
      self
    end


    # out_of_business 和 in_business在Venue中定义为scope方法,判别这个地方是否在经营
    def business
      if closed
        @scope = @scope.out_of_business
      elsif !include_closed

        # > @scope.method(:in_business).source_location
        # => ["/Users/PENG-mac/.rvm/gems/ruby-2.2.4/gems/activerecord-4.2.1/lib/active_record/relation/delegation.rb", 69]

        @scope = @scope.in_business
      end
      self
    end

    def wifi_status
      @scope = @scope.with_public_wifi if wifi
      self
    end

    def search
      @scope = @scope.tagged_with(tag) if tag.present? # searching by tag
      self
    end

    def scope
      @scope
    end
  end
end

