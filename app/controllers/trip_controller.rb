class TripController < ApplicationController
  before_filter do
    @countries = ["Aruba", "Cuba", "Turkije"]
    @popular_countries = [{ :code => "ES", :name => "Spanje"},{ :code => "GR", :name => "Griekenland"}]

    @departure_date = to_date(params[:departure]) || Date.today + 10.days
    @return_date = to_date(params[:return]) || @departure_date + 7.days
    @occupancy = params[:occupancy] || 2

    @duration = to_duration(@departure_date, @return_date)
  end


	def index
    @page = 1
    search = Search.new(@occupancy, @departure_date, @return_date, @page, 9)
    if search.valid?
      puts "valid"
    else
      puts "invalid"
    end
    json = perform_search(@occupancy, @departure_date, @duration, @page)
    @trips = json['accommodations']
  end

  def fetch_more_results
    @page = params[:page] || 1
    search = Search.new(@occupancy, @departure_date, @return_date, @page, 9)
    if search.valid?
      puts "valid"
    else
      puts "invalid"
    end
    json = perform_search(@occupancy, @departure_date, @duration, @page)
    @trips = json['accommodations']
  end

  def search
    search = Search.new(@occupancy, @departure_date, @return_date, 1, 9)
    if search.valid?
      puts "valid"
    else
      puts "invalid"
    end
    json = perform_search(@occupancy, @departure_date, @duration, 1)
    @trips = json['accommodations']
  end

  private
  
  def perform_search(occupancy, departure_date, duration, page, num_results_per_page = 9)
    puts "params: #{occupancy} #{departure_date} #{duration} #{page}"
    ActiveSupport::JSON.decode('{"totalNumberOfResults":622,"totalNumberOfPages":70,"currentPageNumber":1,"accommodations":[{"id":"spanje-regio_madrid-madrid-hotel_francisco_1","shortdescription":"Hotel Francisco I is uitermate centraal gelegen en gesitueerd in een historisch Spaans herenhuis. Het hotel is recentelijk geheel gerenoveerd en voldoet aan alle moderne eisen","accotype":"Hotel","name":"Hotel Francisco 1","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-regio_madrid-madrid-hotel_francisco_1","city":{"code":"madrid","name":"Madrid"},"region":{"code":"regio_madrid","name":"Regio Madrid"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/16810dc5bc5af6d13e958e28636bb3e62c775502f8a5b8d5be20abb3c72ca19d.jpg","small":"http://www.elmar.nl/images/cache/164/16810dc5bc5af6d13e958e28636bb3e62c775502f8a5b8d5be20abb3c72ca19d.jpg","big":"http://www.elmar.nl/images/cache/520/16810dc5bc5af6d13e958e28636bb3e62c775502f8a5b8d5be20abb3c72ca19d.jpg"},"cheapestoffer":{"price":301.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-14"},"reviewscore":7.3,"rating":2},{"id":"spanje-catalonie-barcelona-hotel_comercio","shortdescription":"Dit eenvoudige hotel is zeer centraal gelegen in een zijstraat van de levendige Ramblas en op loopafstand van de goede restaurants in de jachthaven. Dit hotel biedt u een goed","accotype":"Hotel","name":"Hotel Comercio","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-hotel_comercio","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/3eec89abf2106a5afa83563838f503b0512a7322d129f064cb03e62e7d2f9d8e.jpg","small":"http://www.elmar.nl/images/cache/164/3eec89abf2106a5afa83563838f503b0512a7322d129f064cb03e62e7d2f9d8e.jpg","big":"http://www.elmar.nl/images/cache/520/3eec89abf2106a5afa83563838f503b0512a7322d129f064cb03e62e7d2f9d8e.jpg"},"cheapestoffer":{"price":311.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-16"},"reviewscore":6.3,"rating":1},{"id":"spanje-catalonie-barcelona-hotel_roma_reial","shortdescription":"Eenvoudig hotel met sobere maar doelmatig ingerichte kamers. Zeer centraal gelegen in de Gotische Wijk in Barcelona, direct aan een van de bekendste pleinen in de stad, Placa ","accotype":"Hotel","name":"Hotel Roma Reial","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-hotel_roma_reial","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/9bb7b5853fc952a22f1bf5143e9528d726c35a7605811ee9ee1a227fb68f83b0.jpg","small":"http://www.elmar.nl/images/cache/164/9bb7b5853fc952a22f1bf5143e9528d726c35a7605811ee9ee1a227fb68f83b0.jpg","big":"http://www.elmar.nl/images/cache/520/9bb7b5853fc952a22f1bf5143e9528d726c35a7605811ee9ee1a227fb68f83b0.jpg"},"cheapestoffer":{"price":315.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-16"},"reviewscore":6.4,"rating":1},{"id":"spanje-catalonie-barcelona-hotel_transit","shortdescription":"Transit is een verzorgd en klein stadshotel gelegen aan de rand van het centrum in de wijk Sants. Op enkele minuten loopafstand vindt u het belangrijkste treinstation van Barc","accotype":"Hotel","name":"Hotel Transit","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-hotel_transit","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/88b531241085d9496ba7a129ba097c3ae0454fafe0985772a1b4ff95d44ac556.jpg","small":"http://www.elmar.nl/images/cache/164/88b531241085d9496ba7a129ba097c3ae0454fafe0985772a1b4ff95d44ac556.jpg","big":"http://www.elmar.nl/images/cache/520/88b531241085d9496ba7a129ba097c3ae0454fafe0985772a1b4ff95d44ac556.jpg"},"cheapestoffer":{"price":317.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies","duration":6,"occupancy":2,"departureDate":"2012-07-15"},"reviewscore":5.8,"rating":1},{"id":"spanje-catalonie-barcelona-gbb_hotel_auto_hogar","shortdescription":"Prima toeristenklasse hotel met eenvoudig ingerichte kamers. Centraal gelegen in de nabijheid van winkels en restaurants en op slechts 5 min. lopen van de levendige Ramblas. D","accotype":"Hotel","name":"GBB Hotel Auto Hogar","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-gbb_hotel_auto_hogar","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/9b1201d76831e65115f56fa9411c57e31e039fb027607bd93ead80e5a507386a.jpg","small":"http://www.elmar.nl/images/cache/164/9b1201d76831e65115f56fa9411c57e31e039fb027607bd93ead80e5a507386a.jpg","big":"http://www.elmar.nl/images/cache/520/9b1201d76831e65115f56fa9411c57e31e039fb027607bd93ead80e5a507386a.jpg"},"cheapestoffer":{"price":323.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-16"},"reviewscore":6.3,"rating":2},{"id":"spanje-catalonie-barcelona-aparthotel_napols","shortdescription":"Aparthotel Napols biedt comfortabele appartementen, o.a. uitgerust met een kleine maar goede keuken en een woonkamer. Met de nabij gelegen metro bereikt u binnen enkele haltes","accotype":"Hotel","name":"Aparthotel Napols","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-aparthotel_napols","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/f7839cbdac26b69bdc4c74f980ecad04fc50a89f1c7518575f72dd8a77d71460.jpg","small":"http://www.elmar.nl/images/cache/164/f7839cbdac26b69bdc4c74f980ecad04fc50a89f1c7518575f72dd8a77d71460.jpg","big":"http://www.elmar.nl/images/cache/520/f7839cbdac26b69bdc4c74f980ecad04fc50a89f1c7518575f72dd8a77d71460.jpg"},"cheapestoffer":{"price":330.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies","duration":6,"occupancy":2,"departureDate":"2012-07-16"},"reviewscore":8.3,"rating":2},{"id":"spanje-catalonie-barcelona-hotel_oasis","shortdescription":"Dit vriendelijke familiehotel met comfortabele kamers die recent gerenoveerd zijn heeft een centrale ligging in de wijk Ribera. Het strand van Barceloneta, het Picasso Museum,","accotype":"Hotel","name":"Hotel Oasis","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-hotel_oasis","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/572f7368ecea59a09ed25f58d9192b2027661277ab5dc63624dd3875fd66d658.jpg","small":"http://www.elmar.nl/images/cache/164/572f7368ecea59a09ed25f58d9192b2027661277ab5dc63624dd3875fd66d658.jpg","big":"http://www.elmar.nl/images/cache/520/572f7368ecea59a09ed25f58d9192b2027661277ab5dc63624dd3875fd66d658.jpg"},"cheapestoffer":{"price":336.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-14"},"reviewscore":7.3,"rating":3},{"id":"spanje-catalonie-barcelona-hotel_condestable","shortdescription":"Een gemoedelijk stadshotel met eenvoudige kamers. Zeer centraal gelegen, in de wijk El Raval op de hoek van de Placa Universitat, temidden van leuke winkels en gezellige bars.","accotype":"Hotel","name":"Hotel Condestable","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-hotel_condestable","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/f00c4bd3d0ca49e463a9903033eb4384deb49d27d3e8a6c3407a9e3ae8b75c41.jpg","small":"http://www.elmar.nl/images/cache/164/f00c4bd3d0ca49e463a9903033eb4384deb49d27d3e8a6c3407a9e3ae8b75c41.jpg","big":"http://www.elmar.nl/images/cache/520/f00c4bd3d0ca49e463a9903033eb4384deb49d27d3e8a6c3407a9e3ae8b75c41.jpg"},"cheapestoffer":{"price":337.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-14"},"reviewscore":6.9,"rating":2},{"id":"spanje-catalonie-barcelona-internacional_cool_local_hotel","shortdescription":"Sinds het hotel in 2008 geheel is gerenoveerd heeft het zich ontwikkeld tot een van de meest geliefde en goed gewaardeerde hotels die direct aan de Ramblas gelegen zijn. De de","accotype":"Hotel","name":"Internacional Cool Local Hotel","link":"http://trip.elmar.nl/api/v2/accommodations/spanje-catalonie-barcelona-internacional_cool_local_hotel","city":{"code":"barcelona","name":"Barcelona"},"region":{"code":"catalonie","name":"Catalonie"},"country":{"code":"spanje","name":"Spanje"},"profileimages":{"thumb_nail":"http://www.elmar.nl/images/cache/114/9f666ba2beb7c54c82df8767157069c48f901a296f552b971e613e5b702ac824.jpg","small":"http://www.elmar.nl/images/cache/164/9f666ba2beb7c54c82df8767157069c48f901a296f552b971e613e5b702ac824.jpg","big":"http://www.elmar.nl/images/cache/520/9f666ba2beb7c54c82df8767157069c48f901a296f552b971e613e5b702ac824.jpg"},"cheapestoffer":{"price":340.0,"touroperator":"CH","departureairport":"Amsterdam","boardingtype":"Logies/ontbijt","duration":6,"occupancy":2,"departureDate":"2012-07-14"},"reviewscore":7.5,"rating":3}]}')
  end

  def to_duration(departure_date, return_date)
    departure_date.mjd - return_date.mjd + 1
  end

  def to_date(date_string, format = t(:long, :scope => [:date, :formats]))
    Date.strptime(date_string, format) if date_string
  end

end
