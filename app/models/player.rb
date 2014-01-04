########################################################################
# The Player model is designed to hold the player's name and birth year.
# for a single player for a given year. The player can either be
# imported or entered manually. The import format can be a CSV file with
# the following columns:
# 
# * playerID - unique id
# * birthYear
# * nameFirst
# * nameLast
#
# The entire set of player records will be index by player_id, which 
# should be unique.
########################################################################
class Player
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Add call to strip leading and trailing white spaces from all atributes
  strip_attributes  # See strip_attributes for more information
  
  ## CALLBACKS ---------------------------------------------------------
  
  ## ATTRIBUTES --------------------------------------------------------
    
  field :player_id, type: String
  field :birth_year, type: Integer, default: 0
  field :first_name, type: String
  field :last_name, type: String
  
  ## VALIDATIONS -------------------------------------------------------
  
  validates_presence_of :player_id
  validates_uniqueness_of :player_id
  validates_numericality_of :birth_year, allow_blank: true, greater_than_or_equal_to: 1700
  
  ## INDICES -----------------------------------------------------------
  
  index({player_id: 1}, {unique: true, name: "player_index" })
  
  ## PREDEFINED SCOPES -------------------------------------------------
  
  scope :by_player, ->(player){ where(player_id: player).order_by([[:player_id, :asc]]) }
  
  ## PUBLIC CLASS METHODS ----------------------------------------------
  
  ######################################################################
  # Returns number of skipped rows during import.
  ######################################################################
  def self.skipped 
    return @@skipped_rows
  end  
  
  ######################################################################
  # The import method handles importing a CSV file of player records.
  # It will overwrite the current set of players with the new ones
  # imported from the file.
  ######################################################################
  def self.import(file)
    Player.delete_all
    @@skipped_rows = 0
    
    CSV.foreach(file.path, headers: true) do |row|
      if row['playerID'].present?
        player = Player.new
        player.player_id = row['playerID']
        player.birth_year = row['birthYear']
        player.first_name = row['nameFirst']
        player.last_name = row['nameLast'] 
        if !player.save         
          logger.debug("[Player.import] Could not save imported record - error: #{player.errors.full_messages}")
        end
      else  
        @@skipped_rows += 1
      end
    end    
  end

  ## PRIVATE ITEMS -----------------------------------------------------
  
  private
    
  # Number of skipped rows during the import process
  @@skipped_rows = 0  
end
