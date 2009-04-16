class PageController < ApplicationController
#	caches_page :index
#	caches_action :index
	def index
	    @active_tab=params[:active_tab]
            @page = Page.find_by_url(params[:url])
	end
	def highlight
		@page = Page.find_by_url(params[:url])
		if @query=params['query']
            @query.split.each{ |q| @page.text=@page.text.gsub(/#{q}/iu,'<b class="header15red">\0</b>')}
		end	
		render :action=>'index'
	end
end
