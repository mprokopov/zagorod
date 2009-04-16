class Catalogue::WizardController < ApplicationController
  def index
    redirect_to :action=>'step1'
  end
  def step1
    # форма заполнения хозяина или агентства
    @page_title='Добавить участок'
    @active_tab='2'
## очистка выборки 
    session[:departure]=nil ## очистить
    if session[:agency] 
      @agency=session[:agency]
    end
    if session[:owner]
      @owner=session[:owner]
    end
    ## если уже заполнялась анекта - сразу на шаг 2
    if request.post?
      if params['is_owner']
        @owner||=Owner.new
        @owner.attributes=params[:owner]
        if @owner.save
          session[:owner]=@owner
          redirect_to :action=>'step2' 
        end
      elsif params['is_agency']
        @agency||=Agency.new
        @agency.attributes=params[:agency]
        if @agency.save
          session[:agency]=@agency
          redirect_to :action=>'step2' 
        end
      end
        collect_errors(@owner) if @owner
        collect_errors(@agency) if @agency
    end
  end
  def step2
    @shapes=[["-- не выбрано--",""],["прямоугольник","прямоугольник"],["треугольник","треугольник"],["квадрат","квадрат"],["трапеция","трапеция"],["неправильной формы","неправильной формы"]]
    # получить owner_id и agency_id после сохранения предыдущей формы
    # форма добавления участка
    unless session[:agency] || session[:owner]
          flash[:notice]="Необходимо пройти Шаг 1 для добавления карточки"
          redirect_to :action=>'step1' 
          return
    end
    # в сессии должен лежать хотя бы один объект
    @agency=session[:agency] if session[:agency]
    @owner=session[:owner] if session[:owner]
    
    @page_title='Добавить участок'
    @active_tab='2'
    if request.post?
      @lot=Lot.new(params[:lot])
      @lot.departure_id=(params[:kievpoint])
      # соседи
        nature_distances=params[:nature_distance] ## хеш дистанций
        if !params[:nature_type].nil?
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
        if params[:neighbour_type] && @lot.errors.empty?
          neighbour_distances=params[:neighbour_distance] ## хеш дистанций
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
        if params[:route_type] && @lot.errors.empty?
          route_distances=params[:route_distances] # массив

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
        if params[:buildings] && @lot.errors.empty?
        params[:buildings].each do |building|
          @lot.buildings.push(Building.find_by_id(building))
        end
        else
          @lot.errors.add(:buildings,"выберите строения")
        end 
        # рельефы
        if params[:relief] && @lot.errors.empty?
        params[:relief].each do |relief|
          @lot.reliefs.push(Relief.find_by_id(relief))
        end 
        else
          @lot.errors.add(:reliefs,"выберите рельеф")
        end
        # источники шума
        # необязательный параметр
        if params[:noise_source] && @lot.errors.empty?
        params[:noise_source].each do |noise_source|
          @lot.noise_sources.push(NoiseSource.find_by_id(noise_source))
        end 
        end
        # насаждения
        if params[:greens] && @lot.errors.empty?
        params[:green].each do |green|
          @lot.greens.push(Green.find_by_id(green))
        end 
        else
          @lot.errors.add(:greens,"выберите насаждения")
        end
        # возле участка находятся
        if params[:build_objects] && @lot.errors.empty?
        params[:build_objects].each do |build_object|
          @lot.buildobjects.push(Buildobject.find_by_id(build_object))
        end 
        end

        if @lot.errors.empty?
          @lot.save         
          Notifier::deliver_newlot(@lot)
          session[:lot_id] = @lot.id
          flash[:notice]="Спасибо! Ваша заявка номер #{"%05d" % @lot.id.to_s} успешно сохранена"
          redirect_to :action=>'step3'
          return
        else
          collect_errors(@lot)
          @lot.destroy
        end
  end
  end
  ## на шаге 3 подгрузка по очереди фотографий
  ## получить id участка, и по очереди показывать подгруженные фотографии
    def step3
      ## проверка на то, что lot был добавлен на шаге2
      redirect_to :action=>'step2' unless session[:lot_id]
      @lot=Lot.find_by_id(session[:lot_id])
      ## если происходить отправка image путем post
      if request.post? && params[:photo]
        photo=params[:photo] 
        if (photo.is_a? Tempfile and photo.size>0) ## да, бывает и такое, бывает, приходит, типа файл, ан нет, нулевой
          photo_tmp=@lot.photos.new
          photo_tmp.image=photo
          photo_tmp.lot=@lot
          @lot.errors.add(:photo,"Изображение не соответствует требованиям") unless photo_tmp.save 
        end
        
        if params[:commit]=='Сохранить и отправить анкету'
           redirect_to :action=>'finish'
        end
        
        unless @lot.errors.empty?
           collect_errors(@lot)
        end
      end
  end
  
  def finish
    @page_title='Участок успешно добавлен'
    @active_tab='2'
  end
end
