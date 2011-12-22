# adds a coutries' specific states or provinces to the DB
# Look in Rails.root + "db/seed/international_states for the countries you can add.
#
# @usage rake db:add_states country=brazil
namespace :db do
  task :add_states => :environment do

    unless ENV.include?("country")
      puts 'you need to add a country param'
      raise error
    end
    add_country = ENV['country']

    file_to_load  = Rails.root + "db/seed/international_states/#{add_country}_states.yml"
    states_list   = YAML::load( File.open( file_to_load ) )

    states_list.each_pair do |key,state|
      s = State.find_by_abbreviation_and_country_id(state['attributes']['abbreviation'], state['attributes']['country_id'])
      State.create(state['attributes']) unless s
    end
  end

  task :add_cities => :environment do
    include Geokit::Geocoders
    #res=MultiGeocoder.geocode('100 Spear st, San Francisco, CA')
    #puts res.ll # ll=latitude,longitude

    unless ENV.include?("country")
      puts 'you need to add a country param'
      raise error
    end
    add_country = ENV['country']

    file_to_load  = Rails.root + "db/seed/cities/#{add_country}_cities.yml"
    cities_list   = YAML::load( File.open( file_to_load ) )

    puts add_country.humanize

    country = Country.find_by_name(add_country.humanize)

    cities_list.each_pair do |state, cities|
      cities.each do |city|
        s = State.find_by_name_and_country_id(state.humanize.split(' ').map(&:capitalize).join(' '), country.id)
        if s
          c = City.find_by_name_and_state_id(city, s.id)
          unless c
            loc = MultiGeocoder.geocode("#{city}, #{s.abbreviation}")
            if loc.ll.empty?
              loc = MultiGeocoder.geocode("#{city}, #{s.name}")
            end
            City.create(:name => city, :state_id => s.id, :latitude => loc.lat, :longitude => loc.lng)
          end
        else
          puts state
        end
      end
    end

  end
end