=begin
# Various helpers available for use in your view
module CalendarDateSelect::FormHelpers
  def challenge_question_tag
    calendar_date_select_output(tag, image, options, javascript_options)
  end

  # Similar to the difference between +text_field_tag+ and +text_field+, this method behaves like +text_field+
  #
  # It receives the same options as +calendar_date_select_tag+.  Need for time selection is automatically detected by checking the corresponding column meta information of Model#columns_hash
  def challenge_question(object, method, options={})
    obj = options[:object] || instance_variable_get("@#{object}")

    if !options.include?(:time) && obj.class.respond_to?("columns_hash")
      column_type = obj.class.columns_hash[method.to_s].type if obj.class.columns_hash.include?(method.to_s)
      options[:time] = true if column_type == :datetime
    end

    use_time = options[:time]

    if options[:time].to_s=="mixed"
      use_time = false if Date===(obj.respond_to?(method) && obj.send(method))
    end

    image, options, javascript_options = calendar_date_select_process_options(options)

    options[:value] ||=
      if(obj.respond_to?(method) && obj.send(method).respond_to?(:strftime))
        obj.send(method).strftime(CalendarDateSelect.date_format_string(use_time))
      elsif obj.respond_to?("#{method}_before_type_cast")
        obj.send("#{method}_before_type_cast")
      elsif obj.respond_to?(method)
        obj.send(method).to_s
      else
        nil
      end

    tag = ActionView::Helpers::InstanceTag.new_with_backwards_compatibility(object, method, self, options.delete(:object))
    calendar_date_select_output(
      tag.to_input_field_tag( (javascript_options[:hidden] || javascript_options[:embedded]) ? "hidden" : "text", options),
      image,
      options,
      javascript_options
    )
  end
end

# Helper method for form builders
module ActionView
  module Helpers
    class FormBuilder
      def challenge_question(method, options = {})
        @template.calendar_date_select(@object_name, method, options.merge(:object => @object))
      end
      def challenge_answer
      end
    end
  end
end
=end