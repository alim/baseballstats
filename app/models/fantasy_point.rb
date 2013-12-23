########################################################################
# The FantasyPoint model class is designed to hold fantasy point 
# assignments for the following baseball statistics:
# 
# * Home runs
# * RBI's
# * Stolen bases
# * Caught stealing
#
# You can assign integer point values each of the allowable statistics
# The model will on support one persisted instance of the object in 
# the database.
########################################################################
class FantasyPoint
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Add call to strip leading and trailing white spaces from all atributes
  strip_attributes  # See strip_attributes for more information

  ## ATTRIBUTES --------------------------------------------------------
  
  field :home_run, type: Integer
  field :rbi, type: Integer
  field :stolen_base, type: Integer
  field :caught_stealing, type: Integer
  
  ## VALIDATIONS -------------------------------------------------------
  
  validates_presence_of :home_run
  validates_numericality_of :home_run, only_integer: true
  
  validates_presence_of :rbi
  validates_numericality_of :rbi, only_integer: true
  
  validates_presence_of :stolen_base
  validates_numericality_of :stolen_base, only_integer: true
  
  validates_presence_of :caught_stealing
  validates_numericality_of :caught_stealing, only_integer: true
  
  validate :check_count, on: :create
  
  # PRIVATE INSTANCE METHODS  ------------------------------------------
  
  private
  
  ######################################################################
  # The check_count validation verifies that there are no other 
  # Fantasy point object instances. The validation is used to implement
  # a 'Singleton' pattern on the model.
  ######################################################################
  def check_count
    if FantasyPoint.count > 0
      errors[:base] << 'there are too many FantasyPoint records'
    end
  end
end
