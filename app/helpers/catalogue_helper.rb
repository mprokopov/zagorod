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
    
    def page_entries_info(collection, options = {})
      entry_name = options[:entry_name] ||
        (collection.empty?? 'entry' : collection.first.class.name.underscore.sub('_', ' '))
      
      if collection.total_pages < 2
        case collection.size
        when 0; "записей не найдено"
        when 1; "<b>1</b> элемент"
        else;   "<b>всего #{collection.size}</b> позиции"
        end
      else
        %{позиции с <b>%d&nbsp;по&nbsp;%d</b> из <b>%d</b>} % [
          collection.offset + 1,
          collection.offset + collection.length,
          collection.total_entries
        ]
      end
    end
end
