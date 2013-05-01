namespace :cms do
  task :create_admin => :environment do
    email, password = Figaro.env.admin_email.dup, Figaro.env.admin_password
    admin = Admin.find_or_create_by(:email => email)
    admin.password = password
    admin.password_confirmation = password
    admin.save
  end
end

namespace :db do
  namespace :sync do
    task :local do
      uri = URI.parse(Figaro.env.mongohq_url)
      db = uri.path.split('/').last
      [
        "rm -rf dump/*",
        "mongodump -u #{uri.user} -p #{uri.password} --host #{uri.host} --port #{uri.port} -d #{db}",
        "rm dump/#{db}/system.*.bson",
        "mongorestore --drop -d garden-development dump/#{db}"
      ].each { |c| sh(c) }
    end
  end

  namespace :reset do
    task :plantings => :environment do
      Planting.all.each do |planting|
        unless planting.square.box.number == 1
          planting.destroy
        end
      end
    end
  end

  namespace :import do
    task :seeds => :environment do
      [
        [1, "Golden Wax Beans 7 gr."],
        [2, "Organic Golden Beet"],
        [3, "Dolce Di Chioggia Beet"],
        [4, "Arugula Greens"],
        [5, "Turnip (Hakurei Hybrid)"],
        [6, "Petunia"],
        [7, "Rutabaga (American Purple Top)"],
        [8, "Green Grape Tomato"],
        [9, "Persimmon Tomato"],
        [10, "Zapotec Tomato"],
        [11, "Red Fig Tomato"],
        [12, "Crimson Cushion Tomato"],
        [13, "Ferris Wheel Tomato"],
        [14, "Serrano Pepper"],
        [15, "Oxheart Tomato"],
        [16, "Chocolate Cherry"],
        [17, "Red Grape Tomato"],
        [18, "Riesentraube"],
        [19, "Cherokee Purple Tomato"],
        [20, "Orange Banana Tomato"],
        [21, "Black Krim Tomato"],
        [22, "Little Finger Carrot"],
        [23, "Paris Market Carrot"],
        [24, "Solaris Carrot"],
        [25, "Chantenay Red Core Carrot"],
        [26, "Nasturtium Jewel Mix"],
        [27, "White Sweet Alyssum"],
        [28, "Purple Coneflower Echinacea"],
        [29, "Sprouts (Mung Bean)"],
        [30, "Ping Tung Long Eggplant"],
        [31, "Purple Top White Globe Turnip"],
        [32, "Nira Chives"],
        [33, "Nasturtium Alaska"],
        [34, "Radish Easter Egg Blend"],
        [35, "Nasturtium Fiesta Blend"],
        [36, "Radish French Breakfast"],
        [37, "Lettuce Mesclun Q's Special Medley"],
        [38, "Lettuce Mesclun Chef's Gourmet Spicy Mix"],
        [39, "Lettuce Mesclun Farmer's Market Blend"],
        [40, "Lettuce Mesclun Asian Salad Greens"],
        [41, "Lettuce Mesclun Gourmet Baby Greens"],
        [42, "Sprouts (Alfalfa)"],
        [43, "Borage Medicinal"],
        [44, "Texas Hummingbird Sage"],
        [45, "Cucumber (Pickalot Hybrid)"],
        [46, "Squash Black Beauty (Zucchini)"],
        [47, "Squash Yellow Summer Crookneck"],
        [48, "Cucumber Suyo Long"],
        [49, "Speckled Cranberry Bean"],
        [50, "Watermelon Radish Seed"],
        [51, "Rainbow Swiss Chard"],
        [52, "French Breakfast Radish"],
        [53, "Kale Lacinato (Dinosaur)"],
        [54, "Pepper Serrano Chili"],
        [55, "Turga Parsnip"],
        [56, "Tendergreen Bush Beans 7 Gr."],
        [57, "French Baby Leeks Primor"],
        [58, "Little Marvel Pea"],
        [59, "Endive Escarole Mix"],
        [60, "Buttercrunch Lettuce (Bibb/Butterhead)"],
        [61, "Rouge De Hiver Lettuce"],
        [62, "Crimson Forest Bunching Onions"],
        [63, "Tokyo Market Turnip"],
        [64, "Forellenschluss Lettuce"],
        [65, "Escarole Endive"],
        [66, "Ramps (Wild Leeks)"],
        [67, "Victoria Rhubarb"],
        [68, "Japan Green Spindle Bitter Melon"],
        [69, "Hybrid Green Giant Bitter Melon"],
        [70, "Shishito"],
        [71, "Mini Sweet"],
        [72, "Purple Pod Yardlong Bean"],
        [73, "Kaohsiung Yardlong Bean"],
        [74, "Thai Holy Basil, Red Leaf"],
        [75, "Coriander, Slow Bolt Winner"],
        [76, "Red Round Turnip"],
        [77, "Red Target"],
        [78, "Peacock Tail Mustard Green"],
        [79, "Oriental Spinach, Hybrid King of Summer"],
        [80, "Taxi"],
        [81, "Michael Pollan"],
        [82, "Thai"],
        [83, "Kabocha"],
        [84, "Red Cherry"],
        [85, "Anaheim"],
        [86, "Ghost"],
        [87, "Chocolate Stripe"],
        [88, "Sun Gold"],
        [89, "Purple Dark Opal Basil"],
        [90, "Genovese Basil"],
        [91, "Garlic Chives"],
        [92, "Chives"],
        [93, "Pablo Lettuce"],
        [94, "Cincinnati Market Radish"],
        [95, "Cylindra Beet"],
        [96, "Helios Radish"],
        [97, "Thai Basil"],
        [98, "Jaune Flamme"],
        [99, "Dragon Carrot"],
        [100, "Sweet Pea"],
        [101, "Ananas Noire"],
        [102, "Tomatoberry Hybrid"]
      ].each do |seed_pair|
        seed = Seed.find_or_create_by(:catalog_number => seed_pair[0])
        seed.name = seed_pair[1]
        seed.save
      end
    end

    task :boxes => :environment do
      (1..9).to_a.each do |box_number|
        box = Box.find_or_create_by(:number => box_number)
        (1..16).to_a.each do |square_number|
          square = box.squares.find_or_create_by(:number => square_number)
          square.save
        end
        box.save
      end
    end
  end
end

