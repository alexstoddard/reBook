# -*- coding: utf-8 -*-

Condition.create!([
  { :id => 1, :description => "Good", :image => nil, :created_at => "2013-11-13 19:05:31", :updated_at => "2013-11-13 19:05:31" },
  { :id => 2, :description => "Fair", :image => nil, :created_at => "2013-11-13 19:05:42", :updated_at => "2013-11-13 19:05:42" },
  { :id => 3, :description => "Poor", :image => nil, :created_at => "2013-11-13 19:05:55", :updated_at => "2013-11-13 19:05:55" }
])

Location.create!([
  { :id => 1, :name => "UW Seattle", :address => "1410 NE Campus Parkway", :city => "Seattle", :state => "WA", :zip => "98195", :image => "http://www.uwb.edu/getattachment/visitors/uwbothell.jpg", :icon => "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC", :description => "Textbook Trading Hub at UW Seattle Campus", :created_at => "2013-11-13 11:41:19", :updated_at => "2013-11-13 11:41:19" },
  { :id => 2, :name => "UW Bothell", :address => "18115 Campus Way NE", :city => "Bothell", :state => "WA", :zip => "98011", :image => "http://www.uwb.edu/getattachment/visitors/uwbothell.jpg", :icon => "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC", :description => "Textbook Trading Hub at UW Bothell Campus", :created_at => "2013-11-13 11:41:19", :updated_at => "2013-11-13 11:41:19" },
  { :id => 3, :name => "UW Tacoma", :address => "1900 Commerce St", :city => "Tacoma", :state => "WA", :zip => "98402", :image => "http://www.tacoma.uw.edu/sites/default/files/global/images/dougan_commerce.jpg", :icon => "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ8YSFAa0K6irIo9xPQnco1vLmQP8jkpf0cS1NV87s3ZOtfGIXC", :description => "Textbook Trading Hub at UW Tacoma Campus", :created_at => "2013-11-13 11:41:19", :updated_at => "2013-11-13 11:41:19" }
])
