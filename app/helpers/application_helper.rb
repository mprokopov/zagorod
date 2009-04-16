# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sidebar
    render_partial('sidebar')
  end
	def news

	end
	def topmenu
		render_partial("shared/topmenu")
	end
	def leftmenu
		@categories = Category.find_all()
		render_partial("shared/leftmenu", @categories)
	end
	def link_to_with_current_class_if_current(name, 
                                          options = {}, 
                                          html_options = {}, 
                                          *parameters_for_method_reference)
		  if (current_page?(options))
		    if (html_options[:class].length > 0)
		      html_options[:class] += "act"
		    else
		      html_options[:class] = "leftmenu"
		    end
		  end
	  link_to(name, options, html_options, *parameters_for_method_reference)
	end
	def block_in_three(enObject)
		render_partial("shared/table_three_column", enObject)
	end
	def topbanner
		render_component(:controller => 'banner', :action => 'show')
	end
def link_current(name, options={}, html_options={})
  if current_page?(options) 
    html_options[:class]="current"
  else
    html_options[:class]=""
  end
  link_to(name, options, html_options)
end

def link_to_with_current( name, options = {}, html_options = {}, *parameters_for_method_reference )
    if @controller.controller_name == options[:controller]
        html_options[:class] += "_current" unless html_options[:class].blank?
        html_options[:class] =  "current"  if     html_options[:class].blank?
    end
    link_to(name, options, html_options, *parameters_for_method_reference)
end	

def admin_td(name, control)
  html_options={:width=>"20%"}
  html_options[:class]="current" if @controller.controller_name==control 
  content_tag("td", link_to(name, :controller=>control), html_options)
end
def icon(name,alt='')
  image_tag("icons/#{name}.gif",{ :width=>'24', :height=>'24', :border=>'0', :align=>'absmiddle', :hspace=>'3'})+alt
end
def nobr_td(content)
  content_tag('td', content_tag('nobr',content))
end
def error_messages_for(object_name, options = {})
        options = options.symbolize_keys
         object = instance_variable_get("@#{object_name}")
       if object && !object.errors.empty?
        content_tag("div",
           content_tag(
             options[:header_tag] || "h2",
              "#{pluralize(object.errors.count, "ошибка")} не дает сохранить #{object_name.to_s.gsub("_", " ")} по следующим причинам") +
           content_tag("p", "Проблемы со следующими полями:") +
           content_tag("ul", object.errors.full_messages.collect { |msg| content_tag("li", msg) }), "id" => options[:id] || "errorExplanation", "class" => options[:class] || "errorExplanation")
       else
         ""
   end
  end
end
