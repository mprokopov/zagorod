class CatalogueController < ApplicationController
#caches_page :details,:print
## index он же list
helper :sort
include SortHelper

  def index
    @page_title='Каталог участков'
    @active_tab='1'
    
    session[:search]=params[:search] if params[:search]
## если пустое, то проинитить сессионную переменную
    session[:search]||={}
## класс определенный ниже
    search_params=SearchFilterParams.new(session[:search])
  
    @conditions=Caboose::EZ::Condition.new :lots  do
      id==search_params.id if search_params.id
      region_id==search_params.region_id if search_params.region_id>0
      point_x==search_params.point_x if search_params.point_x && search_params.point_x>0
      point_y==search_params.point_y if search_params.point_y && search_params.point_y>0
      square<=>(Square.find_by_id(search_params.square.to_s).min_square.to_s .. Square.find_by_id(search_params.square.to_s).max_square.to_s)  if search_params.square>0
      price_per_square<Price.find_by_id(search_params.price_per_square).max_price.to_s if search_params.price_per_square>0
      full_price<FullPrice.find_by_id(search_params.full_price).max_price.to_s if search_params.full_price>0
      distance_to_city<CityDistance.find_by_id(search_params.distance_to_city).max_distance.to_s if search_params.distance_to_city>0
      placement_id==search_params.placement if search_params.placement>0
      is_reviewed=='1'
   end
## ай-яй-яй, некрасиво   
    @search=search_params
## должен прийти хеш в params[:search]    

## если заданы фильтры    
# order by region_id,square, price_per_square*square, distance
#     sort_init 'price_per_square'
     sort_init 'weights'
     sort_update 
    # @lot_pages, @lots=paginate(:lots,
      # :include=>['region', 'gas','electricity','water', 'lotroad_distance','departure','photos','natures'],
      # :order=>sort_clause,
      # :conditions=>@conditions.to_sql,
      # :per_page=>5
    # )

    @lots = Lot.paginate(:page=>params[:page],
      :include=>['region', 'gas','electricity','water', 'lotroad_distance','departure','photos','natures'],
      :order=>sort_clause,
      :conditions=>@conditions.to_sql,
      :per_page=>5)

#    session[:search]=nil unless request.post?
  end
## фильтр по каталогу  
  def search
    @active_tab='1'  
  end
## детальная анкета
## параметр - id анкеты
  def details
    @active_tab = '1'
    @page_title = "Детали по участку #{params['id']}"
    @lot = Lot.find_by_id(params['id'],:include=>['region', 'gas','electricity','water', 'lotroad_distance', 'lotroad_surface','lotroad_width', 'placement','greens','buildings','reliefs','groundwater_level','noise', 'buildobjects','photos'])
    if !@lot
      redirect_to :action=>'index'
    else
      session[:departure] = @lot.departure.id.to_s
    end
  end  
  def print
    @page_title="Детали по участку #{params['id']}"
    @lot=Lot.find_by_id(params['id'],:include=>['region', 'gas','electricity','water', 'lotroad_distance', 'lotroad_surface','lotroad_width', 'placement','greens','buildings','reliefs','groundwater_level','noise', 'buildobjects','photos'])
    if @lot
      render :layout=>'print'
    else
      redirect_to :action=>'index' 
    end
  end
end

class SearchFilterParams
  attr :id
  attr :region_id
  attr :square
  attr :price_per_square
  attr :full_price
  attr :distance_to_city
  attr :placement
  attr :point_x
  attr :point_y
  def initialize(lparams={:id=>'',:region_id=>['0'],:square=>'0',:price_per_square=>'0',:full_price=>'0',:distance_to_city=>'0',:placement=>'0',:point_x=>'0',:point_y=>'0'})
    @id=lparams[:id]
    @region_id=lparams[:region_id].type == Array ?lparams[:region_id].first.to_i :  lparams[:region_id].to_i
    @square=lparams[:square].to_i
    @price_per_square=lparams[:price_per_square].to_i
    @full_price=lparams[:full_price].to_i
    @distance_to_city=lparams[:distance_to_city].to_i
    @placement=lparams[:placement].to_i
    @point_x=lparams[:point_x].to_i
    @point_y=lparams[:point_y].to_i
  end
  def id
    if @id.to_i>0
      return @id.to_i
    else
      return "" 
    end
  end
end
