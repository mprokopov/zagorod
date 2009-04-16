module Catalogue::WizardHelper
  def checkbox_label_in_td(id,name,value,group=nil)
    html_options={:id=>name+id.to_s}
    html_options[:onclick]="#{group}.check(this)" if group
    content_tag('td',
                check_box_tag("#{name}",id.to_s,false,html_options)
               )+
                 content_tag('td',
                             content_tag('label',value,:for=>name+id.to_s)
                          )
 end
 def input_label(id,name,value,group=nil)
    html_options={:id=>name+id.to_s}
    html_options[:onclick]="#{group}.check(this)" if group
    check_box_tag("#{name}",id.to_s,false,html_options) + content_tag('label',value,:for=>name+id.to_s)
 end
                 def td_input_label(id,name,value,group=nil)
                   content_tag('td',input_label(id,name,value,group))
                 end
                 # генерит с width="100%"
                 def input_text(object,name)
                   html_options={:style=>'width:100%;'}
                   text_field(object,name,html_options)
                 end
               end
