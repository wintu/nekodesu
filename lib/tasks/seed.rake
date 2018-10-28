namespace :seed do
  task ganarate_category: :environment do
    Category.create!(name: '質的データ')
    Category.create!(name: '量的データ')
  end 
end
