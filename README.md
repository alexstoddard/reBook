reBook
======

reBook Main Project Repository
Visit us at our site, hosted @ [Heroku](http://rebook.herokuapp.com):<br>

# What is reBook?

reBook is a book trading hub which aims to make the process of locating your next book fast, free, and automatic. Simply list the books you own, the books you need, your campus and your schedule. The system will automatically propose trades between individuals on campus at agreed upon times. Significantly, reBook will be designed to arrange trades between up to three people. No money changes hands, just books for other books.

# Alpha Release

There are four major components in the Alpha release: site shell (html, css), user account creation, book search results, and Have/Want lists. The site shell is almost complete. We have created a basic design and look for our site and have pages to support our Alpha release features. A few pages are missing at the moment (trades, matches, account preferences) because the features on those pages have not yet been implemented. The user account creation process is fully functional, and email verification works as well. In addition, we have hooked up our book search to use the Google API, and users can then add books to their Have/Want lists.  
  
### Implemented Features  
* Page header content changes depending on if user is logged in or not  
* When a user signs up, an email is sent to them with a verification link to activate their account   
* A user can create an account (first name, last name, username, password, email, location)  
* A user can login with their username/password  
* A user can logout of their account  
* Book search results show a thumbnail image, title, author, isbn, published date, and short description  
* The logged in user can add books to their Have/Want lists from the search results page  
* The user can remove books from their Have/Want lists   
* The Have/Want list pages have a search bar for adding more books to the list  
  
### Incomplete Features  
* Trades and Matches page are not yet created  
* Matching algorithm is not yet implemented   
* Style book details in search results and Have/Want list  
* Account Preference is not yet implemented  
* ”Forgot Password?” is not yet implemented 
* Error messages for account creation not yet added  
* Error messages for login errors not yet added
* Restricting user access of the database is not implemented yet. (Currently, if the user is logged in, the user can view and edit other fields in the database.) 

# Installing from source

If one wants to download our source code and run it on their own machine, some steps are required. The most foolproof method of doing this is to download a virtual appliance which has been previously configured with the appropriate Ruby on Rails version. Our team members are using Ruby Stack Dev 2.0.0-5 (64-bit), available from: http://bitnami.com/stack/ruby/virtual-machine. 

It is necessary to set up port forwarding from the virtual machine to the workstation and share a folder from host to guest, but how to do this depends on the virtual machine monitor you are using. Once the virtual machine is set up on a workstation, login with the username and password ‘bitnami’. At the prompt, the library ‘libmysql3-dev’ must be installed with apt-get: ‘sudo apt-get libmysql3-dev.’ After this, you only need to clone our Github project to a directory, and in that directory run ‘bundle install’ to install the necessary dependencies. Next run the task ‘rake db:migrate’ to setup the database. Finally, you can run ‘rails server’ to launch the application. On the host machine, open a web browser and go to ‘localhost:3000’ to see the site. 

Alternatively: It is possible to download the Ruby stack and run it directly on a personal machine. This simplifies many of the issues in setting up the virtual machine, but this is not the method the ReBook team members are using and is therefore not tested. It may be the case that everything just works in this way, and all you have to do is run ‘bundle install’ in a prompt, followed by ‘rake db:migrate’ and then ‘rails server’, but it is not guaranteed.
