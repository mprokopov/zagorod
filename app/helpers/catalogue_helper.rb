module CatalogueHelper
  def checkbox_label_in_td(id,name,value)
    content_tag('td',
                check_box_tag("#{name}",id.to_s,false,:id=>name+id.to_s)
               )+
    content_tag('td',
                content_tag('label',value,:for=>name+id.to_s)
               )
  end
  def input_label(id,name,value)
    check_box_tag("#{name}",id.to_s,false,:id=>name+id.to_s) + content_tag('label',value,:for=>name+id.to_s)
  end
  def td_input_label(id,name,value)
    content_tag('td',input_label(id,name,value))
  end
# генерит с width="100%"
    def input_text(name)
        tag('input',{:type=>'text',:name=>name,:style=>'width:100%;',:id=>name})
    end
end
