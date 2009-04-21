class MapController < ApplicationController
  def index
    @page_title='Каталог участков'
    @active_tab='1'

    session[:search]=params[:search] if params[:search]
    ## если пустое, то проинитить сессионную переменную
    session[:search]||={}
    ## класс определенный ниже
    search_params=SearchFilterParams.new(session[:search])

    ## ай-яй-яй, некрасиво   
    @search=search_params
    ## должен прийти хеш в params[:search]    

    ## если заданы фильтры    
    # order by region_id,square, price_per_square*square, distance
  end
  ## mapdata.xml
  def mapdata
    session[:search]||={}
    search_params=SearchFilterParams.new(session[:search])

    @conditions=Caboose::EZ::Condition.new :lots  do
      id==search_params.id if search_params.id
      region_id==search_params.region_id if search_params.region_id>0
      square<=>(Square.find_by_id(search_params.square.to_s).min_square.to_s .. Square.find_by_id(search_params.square.to_s).max_square.to_s)  if search_params.square>0
      price_per_square<Price.find_by_id(search_params.price_per_square).max_price.to_s if search_params.price_per_square>0
      full_price<FullPrice.find_by_id(search_params.full_price).max_price.to_s if search_params.full_price>0
      distance_to_city<CityDistance.find_by_id(search_params.distance_to_city).max_distance.to_s if search_params.distance_to_city>0
      placement_id==search_params.placement if search_params.placement>0
      ## не показываем участки без координат
      point_x>0
      point_y>0
      is_reviewed=='1'
    end
    @lots=Lot.find(:all,
      :include=>['region', 'gas','electricity','water', 'lotroad_distance','departure'],
      :conditions=>@conditions.to_sql
    )


    #@lot_pages, @lots=paginate(:lots,
                               #:include=>['region', 'gas','electricity','water', 'lotroad_distance','departure'],
                               #:conditions=>@conditions.to_sql,
                               #:per_page=>50
                              #)
                              @grouped_lots=@lots.group_by{|lot|
      "#{lot.point_x}#{lot.point_y}"
                              }
    render :layout=>false
    session[:search]=nil unless request.post?
  end
  ## Киевская карта отправительных точек
  def kiev
    @page_title='Карта отправных точек'
    render :layout=>'blank'
  end
  ## kievmapdata.xml  
  def kievmapdata
    if session[:departure]
      @departures=Departure.find_all(["id=?",session[:departure]])
    else 
      @departures=Departure.find_all
    end
    render :layout=>false
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
  def initialize(lparams={:id=>'',:region_id=>'0',:square=>'0',:price_per_square=>'0',:full_price=>'0',:distance_to_city=>'0',:placement=>'0'})
    @id=lparams[:id]
    begin
    @region_id=lparams[:region_id].to_i
  rescue
    @region_id=lparams[:region_id].first.to_i
  end
    @square=lparams[:square].to_i
    @price_per_square=lparams[:price_per_square].to_i
    @full_price=lparams[:full_price].to_i
    @distance_to_city=lparams[:distance_to_city].to_i
    @placement=lparams[:placement].to_i
  end
  def id
    if @id.to_i>0
      return @id.to_i
    else
      return "" 
    end
  end
end
