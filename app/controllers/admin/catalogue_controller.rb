class Admin::CatalogueController < ApplicationController
  layout 'admin'
  before_filter :login_required
  def index
    redirect_to :action=>'list'
  end
  def list
    @page_title="Список участков"
    @lots=Lot.reviewed
  end
  def not_reviewed
    @page_title="Список непоказанных участков"
    @lots=Lot.not_reviewed
    render :action=>'list'
  end
  def without_map
    @page_title="Список участков не на карте"
    @lots=Lot.without_map
    render :action=>'list'
  end
  def delete_image
      @lot=Lot.find_by_id(params[:id])
      @lot.photos.find_by_id(params[:image]).destroy
      flash[:notice]='Изображение успешно удалено'
      redirect_to :action=>'images',:id=>@lot
  end
  def addimage
     @lot=Lot.find_by_id(params[:id])
      if request.post?
        newphoto=params[:newphoto][:image]
          if (newphoto.is_a? Tempfile and newphoto.size>0)
            photo_tmp=@lot.photos.new
            photo_tmp.image=newphoto
            photo_tmp.lot=@lot
            flash[:notice]="Изображение успешно добавлено" if photo_tmp.save
            expire_lot(@lot) ## сбросим кеш
          end
      end
      redirect_to :action=>'images',:id=>@lot
  end
  def images
      @lot=Lot.find_by_id(params[:id])
      if request.post?
        if params[:selected_photo_id]
          @lot.selected_photo_id=params[:selected_photo_id]
          @lot.save
        end
        if params[:weights]
          params[:weights].each{ |photo_id,photo_weight| ## массив weights[photo_id]=>weight
            photo=Photo.find_by_id(photo_id)
            photo.weight=photo_weight
            photo.save
          }
        end
      end
  end
  ## редактирование участка
  def edit
    if request.post?
      @lot=Lot.find_by_id(params[:lot][:id])
      # соседи
        nature_distances=params[:nature_distance] ## хеш дистанций
        if !params[:nature_type].nil?
        @lot.natures.clear ## очистка
        params[:nature_type].each do |nature_type|
          Nature.create({
            :nature_type=>NatureType.find_by_id(nature_type), 
            :nature_distance=>NatureDistance.find_by_id(nature_distances['distance'+nature_type.to_s]),
            :lot=>@lot})
        end
        else
          # добавить в ошибки
          @lot.errors.add(:natures,"выберите пейзаж") 
        end 
        if params[:neighbour_type]
          neighbour_distances=params[:neighbour_distance] ## хеш дистанций
          @lot.neighbours.clear
          params[:neighbour_type].each do |neighbour_type|
            Neighbour.create({
              :neighbour_type=>NeighbourType.find_by_id(neighbour_type),
              :neighbour_distance=>NeighbourDistance.find_by_id(neighbour_distances['distance'+neighbour_type.to_s]),
              :lot=>@lot})
          end
        else
          @lot.errors.add(:neighbours, "выберите соседство")
        end 
        # подъезды 
        if params[:route_type]
          route_distances=params[:route_distances] # массив
          @lot.routes.clear
        params[:route_type].each do |route_type|
          Route.create({
            :route_type=>RouteType.find_by_id(route_type),
            :route_distance=>RouteDistance.find_by_id(route_distances['distance'+route_type]),
            :lot=>@lot})
        end
        else
          @lot.errors.add(:routes,"выберите сообщение с Киевом")
        end 

        # строения
        if params[:buildings]
          @lot.buildings.clear
        params[:buildings].each do |building|
          @lot.buildings.push(Building.find_by_id(building))
        end
        else
          @lot.errors.add(:buildings,"выберите строения")
        end 
        # рельефы
        if params[:relief]
          @lot.reliefs.clear
        params[:relief].each do |relief|
          @lot.reliefs.push(Relief.find_by_id(relief))
        end 
        else
          @lot.errors.add(:reliefs,"выберите рельеф")
        end
        # источники шума
        # необязательный параметр
        if params[:noise_source]
          @lot.noise_sources.clear
          params[:noise_source].each do |noise_source|
            @lot.noise_sources.push(NoiseSource.find_by_id(noise_source))
          end 
        end 
        # насаждения
        if params[:greens]
          @lot.greens.clear
          params[:greens].each do |green|
            @lot.greens.push(Green.find_by_id(green))
          end 
        else
          @lot.errors.add(:greens,"выберите насаждения")
        end
        # возле участка находятся
        if params[:build_objects]
          @lot.buildobjects.clear
          params[:build_objects].each do |build_object|
            @lot.buildobjects.push(Buildobject.find_by_id(build_object))
          end 
        end
        if @lot.errors.empty?
        @lot.attributes = params[:lot]
          @lot.save         
          flash[:notice]="Заявка ??? #{@lot.id.to_s} успешно сохранена"
          expire_lot(@lot) ## сбросим кеш
          redirect_to :action=>'list'
          return
        else
          collect_errors(@lot)
        end
    else
      @lot=Lot.find_by_id(params[:id])
    end
  end
  def lotmap
    render :layout=>false
  end
  def delete
    @lot=Lot.find_by_id(params[:id])
    if @lot.destroy 
      flash[:notice]="Участок #{@lot.id.to_s} успешно удален"
      expire_lot(@lot) ## сбросим кеш
    else
      collect_errors(@lot)
    end
    redirect_to :action=>'list'
  end
  def expire_lot(lot)
    expire_page :controller=>'catalogue', :action=>'details', :id=>lot.id
    expire_page :controller=>'catalogue', :action=>'print', :id=>lot.id
  end
end
