# Methods added to this helper will be available to all templates in the application.

module ApplicationHelper
  include TimeRangeHelper

  # Returns HTML string of an event or venue description for display in a view.
  def format_description(string)
    sanitize(auto_link(upgrade_br(markdown(string))))
  end

  def markdown(text)
    BlueCloth.new(text, :relaxed => true).to_html
  end

  # Return a HTML string with the BR tags converted to XHTML compliant markup.
  def upgrade_br(content)
    content.gsub('<br>', '<br />')
  end


  CLASS_FLASH_MAP={
      "success" => "success",
      "failure" => "danger"
  }


  # <% flash.each do |key, value|  %>
  # <% new_key= map_flash_type(key)  %>
  # <% new_value= integrate_flash_value(value,new_key)  %>
  #     <div class="alert alert-<%= new_key  %>"><%= new_value %></div>
  # <% end  %>

  def map_flash_type(type)
    CLASS_FLASH_MAP.each do |key, value|
      if key==type
        return value
      end
    end
  end

  def integrate_flash_value(value, type)

    if type ==CLASS_FLASH_MAP["failure"]
      result="<h3>Error:</h3>"

      if value.kind_of? String
          return "#{result} <h4>#{value}</h4>".html_safe
      end

      value.each do |key, word|
        result = result + content_tag(:h4, content_tag(:li, sanitize("#{key}   #{word.join}")))
      end
      return result.html_safe
    end

    return value
  end


  def datetime_format(time, format)
    format = format.gsub(/(%[dHImU])/, '*\1')
    time.strftime(format).gsub(/\*0*/, '').html_safe
  end


  # returns html markup with source (if any), imported/created time, and - if modified - modified time
  def fromwhere(item)
    source ="added directly to #{Webportal.title}"
    created = " <br /><strong>#{normalize_time(item.created_at, format: :html)}</strong>"
    updated = if item.updated_at > item.created_at
                " <br /> and last updated <br /><strong>#{normalize_time(item.updated_at, format: :html)}</strong>"
              end
    raw "This item was #{source}#{created}#{updated}."
  end

  # Caches +block+ in view only if the +condition+ is true.
  # http://skionrails.wordpress.com/2008/05/22/conditional-fragment-caching/
  def cache_if(condition, name={}, &block)
    if condition
      cache(name, &block)
    else
      block.call
    end
  end

  def subnav_class_for(controller_name, action_name)
    css_class = "#{controller.controller_name}_#{controller.action_name}_subnav"
    css_class += " active" if [controller.controller_name, controller.action_name] == [controller_name, action_name]
    css_class
  end

end

