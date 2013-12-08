# -*- coding: utf-8 -*-

User.enable_mailer = false

User.new({ :username => "afstrings", :email => "rebook.afstrings@gmail.com", :passhash => "rebook123", :passhash_confirmation => "rebook123", :image => "cow.png", :created_at => "2013-11-25 01:34:04", :updated_at => "2013-11-26 18:26:04", :activated => true, :first => "Andy", :last => "Fu", :token => nil }).save(:validate => false, :run_callbacks => false)
User.new({ :username => "dragon", :email => "rebook.dragon@gmail.com", :passhash => "rebook123", :passhash_confirmation => "rebook123", :image => "dragon.png", :created_at => "2013-11-25 01:34:24", :updated_at => "2013-11-26 18:16:18", :activated => true, :first => "Mighty", :last => "Dragoon", :token => nil }).save(:validate => false, :run_callbacks => false)
User.new({ :username => "turing", :email => "rebook.turing@gmail.com", :passhash => "rebook123", :passhash_confirmation => "rebook123", :image => "dragon.png", :created_at => "2013-11-25 01:35:39", :updated_at => "2013-11-25 01:36:33", :activated => true, :first => "Alan", :last => "Turing", :token => nil }).save(:validate => false, :run_callbacks => false)
User.new({ :username => "ycchen92", :email => "rebook.ycchen92@gmail.com", :passhash => "rebook123", :passhash_confirmation => "rebook123", :image => "dragon.png", :created_at => "2013-11-25 01:36:25", :updated_at => "2013-11-25 01:36:37", :activated => true, :first => "Yu-Cheng", :last => "Chen", :token => nil }).save(:validate => false, :run_callbacks => false)
User.new({ :username => "samb0303", :email => "rebook.samb0303@gmail.com", :passhash => "rebook123", :passhash_confirmation => "rebook123", :image => "monkey.png", :created_at => "2013-11-25 01:37:42", :updated_at => "2013-11-26 18:59:29", :activated => true, :first => "Sam", :last => "B", :token => nil }).save(:validate => false, :run_callbacks => false)
User.new({ :username => "wreckingball", :email => "rebook.miley@gmail.com", :passhash => "twerking", :passhash_confirmation => "twerking", :image => "miley.png", :created_at => "2013-11-25 03:41:07", :updated_at => "2013-11-25 18:52:25", :activated => true, :first => "Miley", :last => "Cyrus", :token => nil }).save(:validate => false, :run_callbacks => false)
User.new({ :username => "urbs", :email => "urbshermit@gmail.com", :passhash => "rebook123", :passhash_confirmation => "rebook123", :image => "dog.png", :created_at => "2013-11-26 04:38:24", :updated_at => "2013-11-26 04:40:42", :activated => true, :first => "James", :last => "Stoddard", :token => nil }).save(:validate => false, :run_callbacks => false)

User.update_all(:timezone => "Pacific Time (US & Canada)")
User.update_all(:admin => false)

Condition.create!([
  { :id => 1, :description => "Good", :image => nil, :created_at => "2013-11-13 19:05:31", :updated_at => "2013-11-13 19:05:31" },
  { :id => 2, :description => "Fair", :image => nil, :created_at => "2013-11-13 19:05:42", :updated_at => "2013-11-13 19:05:42" },
  { :id => 3, :description => "Poor", :image => nil, :created_at => "2013-11-13 19:05:55", :updated_at => "2013-11-13 19:05:55" }
])

Location.create!([
  { :id => 1, :name => "UW Seattle", :address => "1410 NE Campus Parkway", :city => "Seattle", :state => "WA", :zip => "98195", :image => "http://fyp.washington.edu/site/assets/files/1064/uwcampus.jpg", :icon => "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC", :description => "A textbook trading hub at the University of Washington's Seattle campus", :created_at => "2013-11-13 11:41:19", :updated_at => "2013-11-13 11:41:19" },
  { :id => 2, :name => "UW Bothell", :address => "18115 Campus Way NE", :city => "Bothell", :state => "WA", :zip => "98011", :image => "http://www.uwb.edu/getattachment/visitors/uwbothell.jpg", :icon => "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC", :description => "A textbook trading hub at the University of Washington's Bothell campus", :created_at => "2013-11-13 11:41:19", :updated_at => "2013-11-13 11:41:19" },
  { :id => 3, :name => "UW Tacoma", :address => "1900 Commerce St", :city => "Tacoma", :state => "WA", :zip => "98402", :image => "http://www.tacoma.uw.edu/sites/default/files/global/images/dougan_commerce.jpg", :icon => "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC", :description => "A textbook trading hub at the University of Washington's Tacoma campus", :created_at => "2013-11-13 11:41:19", :updated_at => "2013-11-13 11:41:19" }
])

UserLocation.create!([
  { :user_id => 1, :location_id => 1, :description => nil, :created_at => "2013-11-25 01:34:04", :updated_at => "2013-11-25 01:34:04" },
  { :user_id => 2, :location_id => 1, :description => nil, :created_at => "2013-11-25 01:34:24", :updated_at => "2013-11-25 01:34:24" },
  { :user_id => 3, :location_id => 1, :description => nil, :created_at => "2013-11-25 01:35:39", :updated_at => "2013-11-25 01:35:39" },
  { :user_id => 4, :location_id => 1, :description => nil, :created_at => "2013-11-25 01:36:25", :updated_at => "2013-11-25 01:36:25" },
  { :user_id => 5, :location_id => 1, :description => nil, :created_at => "2013-11-25 01:37:42", :updated_at => "2013-11-25 01:37:42" },
  { :user_id => 6, :location_id => 1, :description => nil, :created_at => "2013-11-25 03:41:07", :updated_at => "2013-11-25 03:41:07" },
  { :user_id => 7, :location_id => 1, :description => nil, :created_at => "2013-11-25 18:52:47", :updated_at => "2013-11-25 18:52:47" },
])
