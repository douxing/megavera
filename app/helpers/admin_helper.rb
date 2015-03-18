module AdminHelper
  def custom_color_field_tag(color)
    text_field_tag color.name, color.value, class: "form-control"
  end
end
