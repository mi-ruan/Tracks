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
Example of how double rendering is avoided

```
def render_content(content, content_type)
  raise "Double Render Error" if already_built_response?
  res.write(content)
  res.set_header('Content-Type', content_type)
  @already_built_response = true
  session.store_session(@res)
end

def render(template_name)
  path = "views/#{self.class.name.underscore}/#{template_name}.html.erb"
  content = File.read(path)
  erb_template = ERB.new(content).result(binding)
  render_content(erb_template,'text/html')
end
```


 ## Router
 The `Router` creates routes for your controllers and allows the transition between routes.
 Example of forming routers
 ```
 router.draw do
   get Regexp.new("^/tracks$"), TracksController, :index
   get Regexp.new("^/tracks/new$"), TracksController, :new
   get Regexp.new("^/tracks/(?<id>\\d+)$"), TracksController, :show
   post Regexp.new("^/tracks$"), TracksController, :create
 end
 ```


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
