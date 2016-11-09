# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
more_movies = [

  {:title => 'Aladdin’', :rating=> 'G', :release_date => '25-Nov-1992',:description => 'When street rat Aladdin frees a genie from a lamp, he finds his wishes granted. However, he soon finds that the evil has other plans for the lamp -- and for Princess Jasmine. But can Aladdin save Princess Jasmine and his love for her after she sees that he isn t quite what he appears to be?'},
  {:title => 'When Harry Met Sally', :rating => 'R',:release_date => '21-Jul-1989',:description => 'In 1977, college graduates Harry Burns (Billy Crystal) and Sally Albright (Meg Ryan) share a contentious car ride from Chicago to New York, during which they argue about whether men and women can ever truly be strictly platonic friends. Ten years later, Harry and Sally meet again at a bookstore'},
  {:title => 'The Help', :rating => 'PG-13',:release_date => '10-Aug-2011',:description =>'In 1960s Mississippi, Southern society girl Skeeter (Emma Stone) returns from college with dreams of being a writer. She turns her small town on its ear by choosing to interview the black women who have spent their lives taking care of prominent white families. Only Aibileen (Viola Davis), the house'},
  {:title => 'Raiders of the Lost Ark', :rating => 'PG',:release_date => '12-Jun-1981',:description =>'Renowned archeologist and expert in the occult, Dr. Indiana Jones, is hired by the U.S. Government to find the Ark of the Covenant, which is believed to still hold the ten commandments. Unfortunately, agents of Hitler are also after the Ark.'}

 ]

 more_movies.each do |movie|
   Movie.create(movie)
 end