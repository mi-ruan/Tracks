# Tracks

Tracks is a basic VC(View and Controller) Framework written in Ruby and inspired by Rails.
The project implements a basic controller class and router class to provide basic routing 

## Key Features 

## BaseController 
The following methods are used by `BaseController`:
*  render(template_name): render a template that is in the app/views/#{controller_name} directory
*  redirect_to (url): redirect to the url argument 
*  session: manage session cookies as a hash for particular login.
*  flash/flash.now: storage of errors in a hash for error messages
    *  flash errors persists to next session
    * flash.now errors persists only the current session
 
 ## Router 
 The `Router` creates routes for your controllers and allows the transition between routes.
 
 ## Running the Example App
 
 ### Prerequisites 
 Have working Ruby and Bundler   
   1.  `git clone https://github.com/mi-ruan/tracks.git`
   2.  `cd tracks`
   3.  `bundle install`
   4.  `ruby app/tracks.rb`
   5.  Visit `http://localhost:3000/tracks`
   
 ## Future Implementation
 *  Integrate project's controller and views with Rails
 *  create more fleshed out webpage with CRUD
