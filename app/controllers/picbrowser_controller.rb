require 'find'
require 'RMagick'
class PicbrowserController < ApplicationController
  layout 'picbrowser'
  before_filter :init
  caches_action :index, :generate_image_list_javascript
  def init
## по умолчанию  
    session[:current_directory]||='./'
    session[:current_directory]='./' unless CurrentDirectory.exists?(session[:current_directory])
    if params['current_directory']
      session[:current_directory]=params['current_directory'] 
      expire_action :action=>%w(index generate_image_list_javascript)
    end

    @current_directory=CurrentDirectory.new(session[:current_directory])
    @image_collection=ImageCollection.new(@current_directory)
    @directory_list=CurrentDirectory.scan_directories    
  end
  def index
    @image_collection.scan
  end
  def refresh
     @image_collection.scan
     @image_collection.refresh_thumbnails
     expire_action :action=>%w(index generate_image_list_javascript)
     redirect_to :action=>'index'
  end
### честно спижжено с file_column  
  def sanitize_filename(filename)
    filename = File.basename(filename.gsub("\\", "/")) # work-around for IE
    filename.gsub!(/[^a-zA-Z0-9\.\-\+_]/,"_")
    filename = "_#{filename}" if filename =~ /^\.+$/
    filename = "unnamed" if filename.size == 0
    filename
  end
  ### обработка исключений!
  def upload
    if params['picture'] && params['picture'].size>0
      filename=sanitize_filename(params['picture'].original_filename)
      @newPic=UploadedImage.new(filename,@current_directory)
      @newPic.save(params['picture'])
      @newPic.generate_thumbnail("100x100")
      expire_action :action=>%w(index generate_image_list_javascript)      
      flash[:notice]='Файл успешно загружен'
    else
      flash[:notice]='Укажите файл'
    end
      redirect_to :action=>'index'
  end
  ## AJAX details
  def details
    @img=UploadedImage.new(params['filename'],@current_directory).load
  end
  ## AJAX delete image
  def delete
    @img=UploadedImage.new(params['filename'],@current_directory)
    @img.delete
    expire_action :action=>%w(index generate_image_list_javascript)    
  end
  def makedir
    @newdir=params['new_directory']+'/' ## добавим слеш в конец
    if(FileTest.exist?(@current_directory.absolute+@newdir))
      flash[:notice]='Директория уже существует'
    else 
      Dir.mkdir(@current_directory.absolute+@newdir) 
      flash[:notice]='Директория создана'
    end
    session[:current_directory]+=@newdir
    expire_action :action=>%w(index generate_image_list_javascript)    
    redirect_to :action=>'index'
  end
  def generate_image_list_javascript
    @image_collection.load
    render :layout=>'imagelist'  
  end
## возвращает массив дир-рий начиная от @dir
end

class ImageCollection
  attr_reader :images
  attr :current_directory
  def initialize(current_dir)
    @current_directory=current_dir
    @current_directory.create_thumbnail_dir unless @current_directory.has_thumbnail_dir?
    @images=Array.new
## генерим, если нет - директории превьюшек    
    alias reload load
  end
## просто загрузить названя файлов  
  def load
    Dir.foreach(@current_directory.absolute){|filename| @images<<UploadedImage.new(filename,@current_directory) if filename=~/.+\.(gif|png|jp?g)/ }
    return self
  end
## полная загрузка с прогоном по параметрам из изображений
  def scan
    Dir.foreach(@current_directory.absolute){|filename|  @images<<UploadedImage.new(filename,@current_directory).load if filename=~/.+\.(gif|jp?g)/  }  
    return self
  end
  def reload
    @images.clear
    self.load
  end
  def refresh_thumbnails
    @images.each{|i| i.thumbnail.generate(i.image,"100x100")}
  end
  def [](index)
    @images[index]
  end
end

class UploadedImage
  attr_reader :geometry, :thumbnail, :image, :filename
  def initialize(filename,current_path='')
    @filename=filename
    @path=current_path||CurrentDirectory.new('')
    @thumbnail=Thumbnail.new(@filename,@path)
    alias url relative    
  end
  def path=(current_path)
    @path=current_path||CurrentDirectory.new('') #если не установлен, то текущий
  end
  def absolute
    @path.absolute+@filename
  end
  def relative
    @path.relative+@filename
  end
  def has_thumbnail?
    @thumbnail.exists?
  end  
  def delete
    File::delete(@thumbnail.absolute) if @thumbnail.exists?
    File::delete(absolute)
  end
## установить path, иначе будем читать из текущей  
  def load
    begin
      @image=Magick::Image.read(absolute).last
      @geometry="#{@image.rows}x#{@image.columns}"
      @filesize=@image.filesize
    rescue
    end
    return self
  end
  def save(file)
    File.open(self.absolute,"wb"){|f| f.write(file.read)} 
  end
## генерируем тамбнейл, size -> 100x100
  def generate_thumbnail(size='100x100')
    load
    @thumbnail.generate(@image,size)
  end
  def to_s
    self.relative
  end
end
class Thumbnail
THUMBNAIL_DIRECTORY='thumbnails/'
  def initialize(filename,path)
    @path=path||CurrentDirectory.new
    @filename=filename
    alias url relative
  end
  def exists?
    File.exists?(@path.absolute+THUMBNAIL_DIRECTORY+@filename)
  end
  def absolute
    @path.absolute+THUMBNAIL_DIRECTORY+@filename
  end
  def relative
    @path.relative+THUMBNAIL_DIRECTORY+@filename
  end
## Image - RMagick, уже газруженный, size=>XxY
  def generate(image, size='100x100')
    x,y=size.split('x')
    if image
       if (image.columns>x.to_i)||(image.rows>y.to_i)
          image.change_geometry!(size){ |cols, rows, img|
            begin
            img.resize!(cols,rows)
            img.write(self.absolute)
            rescue
            end
           }
        else
          image.write(self.absolute)
        end
    end
  end
  def to_s
    self.relative
  end
end
class CurrentDirectory
  ABSOLUTE_ROOT=RAILS_ROOT+'/public/images/'
  RELATIVE_ROOT='/images/'
  THUMBNAIL_DIRECTORY='thumbnails/'
  attr_reader :path #upload/
 
  def initialize(path='upload/')
    @path=path
    alias url relative
  end
### относительный путь, он же url  
  def relative
      RELATIVE_ROOT+@path
  end
  def relative_thumbnail
      relative+THUMBNAIL_DIRECTORY
  end
  def absolute
      ABSOLUTE_ROOT+@path
  end
  def absolute_thumbnail
      absolute+THUMBNAIL_DIRECTORY
  end
  def create_thumbnail_dir
    begin
      Dir.mkdir(absolute_thumbnail)
     rescue
        logger.error "Cannot create #{absolute_thumbnail}"
     end
  end
  def CurrentDirectory.exists?(path)
      File.exist?(ABSOLUTE_ROOT+path)
  end
  def has_thumbnail_dir?
      File.exist?(absolute_thumbnail)
  end
  def CurrentDirectory.scan_directories
    exclude=[".svn",".","..","svn","tmp", "thumbnails"]
    dirs=Array.new
    Find.find(ABSOLUTE_ROOT) do |dirname| 
        if FileTest.directory?(dirname)
          if exclude.include?(File.basename(dirname))
            Find.prune 
          else
            dirname.sub!(/#{ABSOLUTE_ROOT}/,'')
            dirname+='/'
            dirs<<[dirname,dirname]
            next
          end
        end
    end
    return dirs
  end
  def path=(value)
    @path=value
  end
  def to_s
    @path
  end
  ## возвратим абсолют  
end
