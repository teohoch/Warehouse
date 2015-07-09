module ApplicationHelper
  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def render_flash
    rendered = []
    flash.each do |type, messages|
      if messages.is_a? Array
        messages.each do |m|
          rendered << render(:partial => 'layouts/flash_message', :locals => {:type => type, :message => m}) unless m.blank?
        end
      else
        rendered << render(:partial => 'layouts/flash_message', :locals => {:type => type, :message => messages}) unless messages.blank?
      end
    end
    html = rendered.join.squish
    return html.html_safe
  end

  def bootstrap_class_for flash_type
    { success: 'alert-success', error: 'alert-danger', warning: 'alert-warning', notice: 'alert-info', alert: "alert-danger"}[flash_type.to_sym]
  end

  def link_to_add_fields(name, f, association, hidden = false)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")}, style: "display: #{hidden ? "none" : "visible"}")
  end
end
