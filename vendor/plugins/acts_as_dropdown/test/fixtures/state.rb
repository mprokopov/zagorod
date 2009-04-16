class State < ActiveRecord::Base
  acts_as_dropdown
end

class StateOverride < ActiveRecord::Base
  set_table_name "states"
  acts_as_dropdown :text => "abbreviation"
end