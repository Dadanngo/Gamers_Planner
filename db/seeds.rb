# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
ff14 = Game.find_or_create_by!(title: 'FF14')
mh = Game.find_or_create_by!(title: 'モンスターハンター')

DataCenter.find_or_create_by!(name: 'elemental', game: ff14)
DataCenter.find_or_create_by!(name: 'gaia', game: ff14)
DataCenter.find_or_create_by!(name: 'mana', game: ff14)
DataCenter.find_or_create_by!(name: 'meteor', game: ff14)
