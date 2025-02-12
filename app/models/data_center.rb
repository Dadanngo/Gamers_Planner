class DataCenter < ApplicationRecord
  belongs_to :game, foreign_key: 'game_id'
  has_many :events
end
