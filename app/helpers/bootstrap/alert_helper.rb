# Rails helpers for producing Bootstrap alert boxes.
#
# See: http://twitter.github.io/bootstrap/components.html#alerts
# 
# @example
#   <%= alert('Default alert') %>
# 
#   <%= alert('Watch out!', :error) %>
#
#   <%= alert('This is the body', heading: 'Title') %>
#
#   <%= alert :success do %>
#     <%= alert_heading('A List') %>
#     <ul>
#       <li>One</li>
#       <li>Two</li>
#     </ul>
#   <% end %>
module Bootstrap::AlertHelper
  InvalidAlertTypeError = Class.new(StandardError)
  
  ALERT_ATTRIBUTES = %w(default success info warning danger)
  COMPILED_ALERT_CLASSES = ALERT_ATTRIBUTES.map{|a| "alert-#{a}"}

  # @overload alert(text, alert_type, options={})
  #   @param text [String] text of the label
  #   @param alert_type [Symbol, String] if present must be one of {Bootstrap::AlertHelper::ALERT_ATTRIBUTES}
  #   @param options [Hash] unrecognized options become html attributes for returned alert <div>
  #   @option options [String] :heading if present, include a heading in the alert
  #   @option options [Boolean] :close if +false+, don't include a close link ('x')
  # @return [String] Returns html for alert
  def alert(*args, &block)
    body = alert_body(args, &block)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'alert')
    options = add_alert_classes(options, args)
    heading = options.delete(:heading)
    show_close = options.delete(:close) != false 
    options = ensure_class(options, 'alert-dismissible') if show_close
    
    content_tag(:div, options) do
      alert_close(show_close) + 
      alert_heading(heading) + 
      body
    end
  end
  
  # Return an alert box close button
  #
  # @return [String] html for alert close button unless _show_ is +false+
  def alert_close(show=true)
    return '' unless show
    content_tag(:button, '&times;'.html_safe, class: 'close', data: {dismiss: 'alert'}, aria: {label: "Close"})
  end

  # Return an alert heading
  #
  # @return [String] html for alert heading unless _heading_ is blank.
  def alert_heading(heading)
    return '' unless heading.present?
    content_tag(:h4, heading)
  end
  
  private
  
  def alert_body(args, &block)
    if block_given?
      capture(&block)
    else
      args.shift
    end
  end
  
  def add_alert_classes(options, alert_attributes)
    validate_alert_attributes(alert_attributes)
    classes = ['alert'] + alert_attributes.map { |e| "alert-#{e}" }
    classes << "alert-default" if is_default?(classes, options, alert_attributes)
    ensure_class(options, classes)
  end
  
  def validate_alert_attributes(alert_attributes)
    alert_attributes.each { |e| raise(InvalidAlertTypeError, e.inspect) unless ALERT_ATTRIBUTES.include?(e.to_s) }
  end
  
  def is_default?(classes, options, alert_attributes)
    classes == ['alert'] &&
     !options[:class].any?{|c| COMPILED_ALERT_CLASSES.include?(c)}
  end
  
end