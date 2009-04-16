# == Schema Information
# Schema version: 45
#
# Table name: lots
#
#  id                            :integer(11)   not null, primary key
#  area                          :string(200)   default(), not null
#  square                        :float         default(0.0), not null
#  price_per_square              :integer(11)   default(0), not null
#  is_price_changeble            :boolean(1)    not null
#  distance_to_city              :float         default(0.0), not null
#  departure_id                  :integer(11)   default(0), not null
#  lotroad_distance_id           :integer(11)   default(0), not null
#  lotroad_surface_id            :integer(11)   default(0), not null
#  lotroad_width_id              :integer(11)   default(0), not null
#  is_another_routes             :boolean(1)    not null
#  gas_id                        :integer(11)   default(0), not null
#  electricity_id                :integer(11)   default(0), not null
#  water_id                      :integer(11)   default(0), not null
#  nearest_shop_distance         :float         default(0.0)
#  nearest_kiosk_distance        :float         default(0.0)
#  nearest_commerce_another      :text          
#  placement_id                  :integer(11)   default(0), not null
#  placement_another             :text          default(), not null
#  nature_types_another          :text          default(), not null
#  lot_length                    :float         default(0.0), not null
#  lot_width                     :float         default(0.0), not null
#  lot_shape                     :string(200)   default(), not null
#  ground_id                     :integer(11)   default(0), not null
#  ground_another                :text          default(), not null
#  building_another              :text          default(), not null
#  green_another                 :string(200)   default(), not null
#  relief_another                :text          default(), not null
#  groundwater_level_id          :integer(11)   default(0), not null
#  noise_source_another          :text          default(), not null
#  buildobjects_another          :text          default(), not null
#  extra_info                    :text          default(), not null
#  region_id                     :integer(11)   default(0), not null
#  square_for_building           :float         default(0.0), not null
#  noise_id                      :integer(11)   default(0), not null
#  full_price                    :integer(11)   default(0), not null
#  lotroad_surface_another       :string(200)   default(), not null
#  nearest_shop_distance_another :string(200)   default(), not null
#  is_reviewed                   :boolean(1)    not null
#  point_x                       :integer(11)   default(0), not null
#  point_y                       :integer(11)   default(0), not null
#  agency_id                     :integer(11)   
#  owner_id                      :integer(11)   
#  created_on                    :datetime      
#  updated_on                    :datetime      
#

class Lot < ActiveRecord::Base
  
  validates_presence_of :area,
                        :message=>'Населенный пункт не должен быть пустым'
  validates_presence_of :square,
                        :message=>'Площать не может быть пустой'
  validates_presence_of :price_per_square,
                        :message=>'Цена не может быть пустой'
  validates_presence_of :square_for_building,
                        :message=>'Площать не может быть пустой'
  validates_presence_of :distance_to_city,
                        :message=>'Расстояние до Киева не может быть пустым'
  validates_presence_of :lotroad_surface_id,
                        :message=>'покрытие не может быть пустым'
  validates_presence_of :lotroad_width_id,
                        :message=>'ширина покрытия не может быть пустой'
  validates_presence_of :placement_id,
                        :message=>'расположение не может быть пустым'
  validates_presence_of :lot_width,
                        :message=>'ширина участка не может быть пустой'
  validates_presence_of :lot_length,
                        :message=>'длина участка не может быть пустой'
  validates_presence_of :ground_id,
                        :message=>'тип грунта не может быть пустым'
  validates_presence_of :groundwater_level_id,
                        :message=>'уровень подводных вод не может быть пустым'
  validates_presence_of :noise_id,
                        :message=>'уровень шума не может быть пустым'
  belongs_to :region
  belongs_to :departure
  belongs_to :gas
  belongs_to :electricity
  belongs_to :water  
  has_many :natures, :include=>[:nature_type, :nature_distance]
  has_many :routes, :include=>[:route_type, :route_distance]  
  has_many :neighbours, :include=>[:neighbour_type, :neighbour_distance]    
  belongs_to :lotroad_distance
  belongs_to :lotroad_surface
  belongs_to :lotroad_width
  belongs_to :placement  
  belongs_to :ground
  has_and_belongs_to_many :greens
  has_and_belongs_to_many :buildings  
  has_and_belongs_to_many :reliefs  
  belongs_to :groundwater_level  
  belongs_to :noise  
  belongs_to :owner
  belongs_to :agency
  has_many :photos
  has_and_belongs_to_many :noise_sources
  has_and_belongs_to_many :buildobjects
  has_many :contact_requests
  def before_save
    self.full_price=self.price_per_square*self.square*100
  end
  def before_destroy
    clear_habtm
  end
def clear_habtm
    self.reliefs.clear
    self.natures.clear
    self.greens.clear
    self.buildings.clear
    self.routes.clear
    self.neighbours.clear
    self.noise_sources.clear
    self.buildobjects.clear
end
## утверждены к просмотру
  def self.reviewed
    find_all_by_is_reviewed(1, :order=>"weights DESC")
  end
  ## ждут утверждения
  def self.not_reviewed
    find_all_by_is_reviewed(0, :order=>"created_on DESC")
  end
  ## отбор участков без карты
  def self.without_map
    find_all_by_point_x_and_point_y(0,0)
  end
  ## утвердить
  def self.approve
    self.is_reviewed=1
    save
  end
end
