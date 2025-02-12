class Game < ApplicationRecord
   has_many :data_centers, foreign_key: 'game_title_id'
   has_many :events, foreign_key: 'game_title_id'
end
