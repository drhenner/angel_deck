module ApplicationHelper

  ### The next three helpers are great to use to add and remove nested attributes in forms.
  #  LOK AT THIS WEBPAGE FOR REFERENCE
  ## http://openmonkey.com/articles/2009/10/complex-nested-forms-with-rails-unobtrusive-jquery
=begin
EXAMPLE USAGE!!
  <% form.fields_for :properties do |property_form| %>
    <%= render :partial => '/admin/merchandise/add_property', :locals => { :f => property_form } %>
  <% end %>
  <p><%= add_child_link "New Property", :properties %></p>
  <%= new_child_fields_template(form, :properties, :partial => '/admin/merchandise/add_property')%>
=end
  def site_name
    I18n.t(:company)
  end

  def remove_child_link(name, f)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0)", :class => "remove_child")
  end

  def add_child_link(name, association)
    link_to(name, "javascript:void(0);", :class => "add_child", :"data-association" => association)
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:locals] ||= {}
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        raw( render(:partial => options[:partial], :locals => {options[:form_builder_local] => f }.merge(options[:locals])) )
      end
    end
  end

  def set_error_class(model, method)
    return ''  if error_message_on(model, method).blank?
    ' error'
  end
end
