# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@uwseattle = Location.create(name: 'UW Seattle', address: '1410 NE Campus Parkway', 
                city: 'Seattle', state: 'WA', zip: '98195', 
                image: 'http://2.bp.blogspot.com/-4a3_CkuS3OE/Ua-tnYhiPoI/AAAAAAAAAis/z1HaRbyPjwk/s1600/0x600.jpg', 
                icon: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC', 
                description: 'Textbook Trading Hub at UW Campus')
@uwbothell = Location.create(name: 'UW Bothell', address: '18115 Campus Way NE', 
                city: 'Bothell', state: 'WA', zip: '98011', 
                image: 'http://www.uwb.edu/getattachment/visitors/uwbothell.jpg', 
                icon: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC', 
                description: 'Textbook Trading Hub at UW Bothell Campus')
@uwtacoma = Location.create(name: 'UW Tacoma', address: '1900 Commerce St', 
                city: 'Tacoma', state: 'WA', zip: '98402', 
                image: 'http://www.tacoma.uw.edu/sites/default/files/global/images/dougan_commerce.jpg', 
                icon: 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC', 
                description: 'Textbook Trading Hub at UW Tacoma Campus')

Condition.create(description: 'Good', image: 'http://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&docid=Zw3yQa_t8gvJqM&tbnid=ebOrs_6pC0Im6M:&ved=0CAUQjRw&url=http%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3AGreen_star_41-108-41.svg&ei=kLGBUq_aLqKNigL_7oAg&bvm=bv.56343320,d.cGE&psig=AFQjCNG-kiZjlizjjB9VcqjB_wQAih92QA&ust=1384317625559177')

Condition.create(description: 'Fair', image: 'http://upload.wikimedia.org/wikipedia/commons/a/a3/Orange_star.svg')

Condition.create(description: 'Poor', image: 'http://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&docid=LBNVkPYc1RJbjM&tbnid=rGNOPLq3bwU27M:&ved=0CAUQjRw&url=http%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ARed_star.svg&ei=K7GBUuHdM-eXigLU4oEg&bvm=bv.56343320,d.cGE&psig=AFQjCNG3F3k-tsooXzm5L_ysCxujAdDdTg&ust=1384317603710974')

@user = User.create(username: 'admin', email: 'admin@rebook.com', passhash: 'abcdefgh', image: 'http://cdn.boardgamearena.net/data/arms/3670/player_3670789.png?h=da4f5a607a', activated: true)

@user.user_locations.create(:location_id => 1, :description => 'Student at UW')
