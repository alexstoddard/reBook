reBook
======

reBook Main Project Repository  
Visit us at our site, hosted @ [Heroku](http://rebook.herokuapp.com):<br>

# What is reBook?

reBook is a book trading hub which aims to make the process of locating your next book fast, free, and automatic. Simply list the books you own, the books you need, your campus and your schedule. The system will automatically propose trades between individuals on campus at agreed upon times. Significantly, reBook will be designed to arrange trades between up to three people. No money changes hands, just books for other books.

### Instructions on how to run and test for “1.0” release:  
* Create Account  
 * On the home page, click on Create an Account on  the top right corner.   
 * Fill in the form.   
 * The page will throw specific errors with regard to these restrictions:    
    * the username/email is already in the database  
    * the email is not valid  
    * the password doesn’t match the confirm password  
    * the password is not at least 8 characters long  
    * the username is not at least 4 characters long  
    * the terms of service box is not checked  
 * A validation email will be sent to the provided email account with the validation link. The user will not be able to log in if the account is not validated through the email link.  
* Forgot Password/Password Reset  
 * On the home page, click on “Forgot Password?” on the top right corner of the page to reset password. 
Enter the the email associating to the account.   
 * An email with the reset password link will be sent to the email account.  
 * The link will direct the user to put in their new password.  
* Typical Use Case
 * The user can search for a book by title, author, or ISBN to find the desired books. (The search bar can be accessed on the home page, Want list page, Have list page, Match list page. In addition, for the pages that don’t have a search bar in them, by pointing the mouse on the search icon on the top right corner of the page, you will see a search bar for easy book searching.   
 * On the search result page, for each book result, the user can click on either “Add To Want List” or “Add To Have List.”  
     * If the user already has a specific book in the “Want List”, then the button to add the book to the “Want List” will be replaced by a message that says the book is already in the “Want List”.  
     * If the user already has a specific book in the “Have List”, then the button to add the book to the “Have List” will be replaced by a message that says the book is already in the “Have List”  
     * The user cannot have the same book in both the “Have List” and the “Want List”.  
 * After clicking on “Add to Have List”, a user can choose what condition their book is in: Poor, Fair, and Good. There’s also a button to cancel the action of adding the books to the two lists if the user misclicked on the book. The user must submit the book condition for the book to be added to the list.  
 * After adding a few books to the “Have List” and “Want List”, clicking on the “My Matches” page will display a list of available matches that the user can trade with.   
 * If there are matches for a book that the user wants, the user can press “Propose a Trade” to view them.  
 * If the user wants to propose a trade after pressing the “Propose a Trade” link, the user can press the “Propose Trade” button on a specific trade. The user then inputs their suggested meet time and date, location, and comments for the trade.  
 * After proposing a trade with another user, the other users involved in the trade can (Accept, Counter, Reject) a trade. Countering a proposal means proposing a new time and meeting place.   
    * If any user counters the trade, the other users will have to accept the trade again.
 * Once all parties have accepted, the trade can be viewed in the “My Trades” section.  
    * Currently “My Trades” only displays trades where all users involved in the trade have accepted.  
    * If a user updates the trade after everyone has accepted, the trade will not be displayed in “My Trades” and the other users will have to accept the trade again through the “My Matches” page.  
* Three-Trades  
  * To test for three-way trades, pick a user in the data base, and then add in a random book A in the “Have List” and a random book B in the “Want List.”  
  * Pick another user in the data base, and then add in book B from above, to the “Have List”. And then add in book C in the “Want List.”  
  * Pick another user in the data base, and then add in book C from above, to the “Have List.” And then add in book A from above, to the “Want List.”  

  
### Full Implemented Features:  
* Matching of books(two-way and three-way)  
 * The Matches page show possible two-way and three-way trades.  
* Email notification of trade offers  
 * On the matches page, when a user clicked on the “proposed” button, an email will be sent to the other users who are involved in the trade.   
 * The email contains trade information and the message from the proposer.  
* Adding conditions for books  
 * When adding book to either lists, the user can pick from a drop down bar specifying the condition that the book is in.   
 * The user is able to edit individual book conditions in their Have list after the book has been added from the book search.   
* Forgot Password   
 * If the user forgets their password, they can enter in their email or username and receive an email containing a link to create a new password.  
* Editing User Account  
 * A user can change their password, email, and username  
* Proposing Trade  
 * The user can propose a trade after our system creates the matches.  
 * When proposing a trade, the user can specify:  
     * what time to meet up  
     * where to meet  
     * comments for the trade    
 * An email will be sent with the trade information to the other users.  
* Accepting/Declining a trade
 * Users can append notes when accepting/denying a trade  
 * A user can suggest another time/date/place   
 * When a user accepts a trade, the other possible trades involving that book is now declined.  
 * After all parties accept the offer, the trade is moved to the “My Trades” page.  
 * Users can view current and previous messages and proposed time/place/date   
* My Trades Page
 * Only displays trades where all users have accepted or declined the trade.  
 * Plan on displaying all trades that the user is involved in (proposed/declined/active).   
* User Restriction  
 * The average user should not have access to all the pages. And when the user is not log in to the website, the user shouldn’t be able to access all the pages as well. The code for restricting user access exists, but there might be a cleaner way to restrict user access rather than hardcoding the urls and redirect the user. The user restriction functionality is temporarily disabled for the purpose of debugging trade functionality.   
* Use SSL redirection wherever possible. Heroku has its own SSL certificate.    
* User ratings.

### Partially Implemented Features:   
* User time schedule(available times)
 * A user can input their available times and days of the week in the “My Account” page.  
 * When proposing a trade, it does not utilize the time schedule yet.    
 
# Installing from source

If one wants to download our source code and run it on their own machine, some steps are required. The most foolproof method of doing this is to download a virtual appliance which has been previously configured with the appropriate Ruby on Rails version. Our team members are using Ruby Stack Dev 2.0.0-5 (64-bit), available from: http://bitnami.com/stack/ruby/virtual-machine. 

It is necessary to set up port forwarding from the virtual machine to the workstation and share a folder from host to guest, but how to do this depends on the virtual machine monitor you are using. Once the virtual machine is set up on a workstation, login with the username and password ‘bitnami’. At the prompt, the library ‘libmysql3-dev’ must be installed with apt-get: ‘sudo apt-get libmysql3-dev.’ After this, you only need to clone our Github project to a directory, and in that directory run ‘bundle install’ to install the necessary dependencies. Next run the task ‘rake db:migrate’ to setup the database. Finally, you can run ‘rails server’ to launch the application. On the host machine, open a web browser and go to ‘localhost:3000’ to see the site. 

Alternatively: It is possible to download the Ruby stack and run it directly on a personal machine. This simplifies many of the issues in setting up the virtual machine, but this is not the method the ReBook team members are using and is therefore not tested. It may be the case that everything just works in this way, and all you have to do is run ‘bundle install’ in a prompt, followed by ‘rake db:migrate’ and then ‘rails server’, but it is not guaranteed.
