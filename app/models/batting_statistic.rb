########################################################################
# The BattingStatistic model is designed to hold the batting statistics
# for a single player for a given year. The statistics can either be
# imported or entered manually. The import format can be a CSV file with
# the following columns:
# 
# * playerID
# * yearID 
# * teamID
# * G - games played
# * AB - at batts
# * R - runs scored
# * H - hits
# * 2B - doubles
# * 3B - triples
# * HR - home runs
# * RBI - runs batted in 
# * SB - stolen bases
# * CS - caught stealing
#
# Each instance of the model object will also include calculated
# statistics for batting average and slugging percentage. These values
# will be calculated in callback methods. The entire set of batting
# statistics will be index by player_id.
########################################################################
class BattingStatistic
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Add call to strip leading and trailing white spaces from all atributes
  strip_attributes  # See strip_attributes for more information
  
  ## CALLBACKS ---------------------------------------------------------
  
  before_save :calc_batting_average
  before_save :calc_slugging_percent
  
  ## ATTRIBUTES --------------------------------------------------------
  
  field :player_id, type: String
  field :year, type: String
  field :team, type: String
  field :games_played, type: Integer, default: 0
  field :at_bats, type: Integer, default: 0
  field :runs_scored, type: Integer, default: 0
  field :hits, type: Integer, default: 0
  field :doubles, type: Integer, default: 0
  field :triples, type: Integer, default: 0
  field :home_runs, type: Integer, default: 0
  field :runs_batted_in, type: Integer, default: 0
  field :stolen_bases, type: Integer, default: 0
  field :caught_stealing, type: Integer, default: 0
  field :batting_average, type: Float, default: 0.0
  field :slugging_percent, type: Float, default: 0.0
  
  ## VALIDATIONS -------------------------------------------------------
  
  validates_presence_of :player_id
  validates_numericality_of :games_played, greater_than_or_equal_to: 0
  validates_numericality_of :at_bats, greater_than_or_equal_to: 0
  validates_numericality_of :runs_scored, greater_than_or_equal_to: 0
  validates_numericality_of :hits, greater_than_or_equal_to: 0
  validates_numericality_of :doubles, greater_than_or_equal_to: 0
  validates_numericality_of :triples, greater_than_or_equal_to: 0
  validates_numericality_of :home_runs, greater_than_or_equal_to: 0  
  validates_numericality_of :runs_batted_in, greater_than_or_equal_to: 0
  validates_numericality_of :stolen_bases, greater_than_or_equal_to: 0
  validates_numericality_of :caught_stealing, greater_than_or_equal_to: 0
  
  ## INDICES -----------------------------------------------------------
  
  index({player_id: 1}, {name: "player_index" })


  ## PREDEFINED SCOPES -------------------------------------------------

  scope :by_player, ->(player){ where(player_id: player).order_by([[:player_id, :asc]]) }
  
  # Returns results for a given year with min. at bats and sorted by player
  scope :by_year, ->(year, minbats){ where(year: year).gt(at_bats: minbats).order_by([[ :player_id, :asc ]])}
  
  # Returns results for a given year and team ordered by slugging percent
  scope :team_slugging, ->(year, team){ where(year: year, team: team).order_by([[ :slugging_percent, :desc ]])}

  ## PUBLIC CLASS METHODS ----------------------------------------------

  ######################################################################
  # Returns number of skipped rows during import.
  ######################################################################
  def self.skipped 
    return @@skipped_rows
  end  
  
  ######################################################################
  # The import method handles importing a CSV file of batting statistics.
  # It will overwrite the current set of statistics with the new ones
  # imported from the file.
  ######################################################################
  def self.import(file)
    BattingStatistic.delete_all
    @@skipped_rows = 0
    
    CSV.foreach(file.path, headers: true) do |row|
      if row['playerID'].present?
        stats = BattingStatistic.new
        stats.player_id = row['playerID']
        stats.year = row['yearID']
        stats.team = row['teamID']
        stats.games_played = row['G'] if !row['G'].nil?
        stats.at_bats = row['AB'] if !row['AB'].nil?
        stats.runs_scored = row['R'] if !row['R'].nil?
        stats.hits = row['H'] if !row['H'].nil?
        stats.doubles = row['2B'] if !row['2B'].nil?
        stats.triples = row['3B'] if !row['3B'].nil?
        stats.home_runs = row['HR'] if !row['HR'].nil?
        stats.runs_batted_in = row['RBI'] if !row['RBI'].nil?
        stats.stolen_bases = row['SB'] if !row['SB'].nil?
        stats.caught_stealing = row['CS'] if !row['CS'].nil?

        if !stats.save         
          logger.debug("[BattingStatistic.import] Could not save imported record - error: #{stats.errors.full_messages}")
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
    
  ######################################################################
  # The calc_batting_average will calculate the batting average and 
  # and store it in the model. This method is designed to be used
  # as a before_save callback.
  ######################################################################
  def calc_batting_average
    self.batting_average = hits / at_bats.to_f if at_bats > 0
  end

  ######################################################################
  # The calc_slugging_percent will calculate the slugging percentage and
  # store the value in the model object. This method is designed to be
  # used as a before_save callback.
  ######################################################################    
  def calc_slugging_percent
    self.slugging_percent = ((hits - doubles - triples - home_runs) + 
      (2 * doubles) + (3 * triples) + (4 * home_runs)) / at_bats.to_f if
      at_bats > 0 
  end
  
end
