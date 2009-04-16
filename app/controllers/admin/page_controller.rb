class Admin::PageController < ApplicationController
	layout 'admin', :except=>'update_preview'
	before_filter :login_required
    uses_tiny_mce(:options => {:theme => 'advanced',
                           :browsers => %w{msie gecko},
                           :content_css => "/stylesheets/content_styles.css",                           
                           :theme_advanced_toolbar_location => "top",
                           :theme_advanced_toolbar_align => "left",
                           :theme_advanced_resizing => true,
                           :theme_advanced_resize_horizontal => false,
                           :file_browser_callback => "myBrowserInstance.fileCallBack",                           
                           :external_image_list_url => "/javascripts/imagelist.js",                            
                           :paste_auto_cleanup_on_paste => true,
                           :theme_advanced_buttons1 => %w{styleselect separator bold italic underline strikethrough separator justifyleft justifycenter justifyright justifyfull indent outdent separator bullist numlist forecolor backcolor separator link unlink anchor image separator undo redo},
                           :theme_advanced_buttons2 => %w{formatselect fontselect fontsizeselect pastetext pasteword cleanup},
                           :theme_advanced_buttons3 => %w{fullscreen selectall tablecontrols separator removeformat visualaid separator code separator preview save},
                           :theme_advanced_statusbar_location => "bottom",
                           :paste_create_paragraphs => false,
                           :paste_use_dialog => true,
                           :onchange_callback => "updatePreview",
                           :plugins => %w{fullscreen preview paste advimage table advhr advlink contextmenu save},
                           :language => "ru_UTF-8",
                           :extended_valid_elements => "table[class|border=0|hspace|vspace|width|height|align|cellpadding|cellspacing|background|bgcolor|name|style],td[dir|class|colspan|rowspan|width|height|align|valign|background|style|bgcolor],span[class|align|style],nobr,hr[class|width|size|noshade],tbody[class|style],a[name|href|target|title|onclick], input[type|class|style|size|name|id|value]"},
                           :only => [:edit])        
	
  def index
    redirect_to(:action => "list")
  end
  
  def list
    @pages=Page.find_all()
  end
  
  def edit
    @page=Page.find_by_id(params['id'])
  end
  
  def update
    @page=Page.find_by_id(params['id'])
    @page.text=params['text']
    if @page.save
        flash[:notice]="Страница #{@page.title} успешно сохранена!"
        expire_page :controller=>'page',:url=>@page.url
        redirect_to(:action=>'list')
    else
        flash[:notice]="Глюк при сохранении"              
    end
  end
  
  def update_preview
    @page=Page.find_by_id(params['id'])
    @page.preview=params['preview']
    if @page.save
        expire_page :controller=>"page", :action=>'index',:url => params['url']    
    else
        flash.now[:notice]="Глюк при сохранении"              
    end
  end

end
