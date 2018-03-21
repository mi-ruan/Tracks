require 'rack'
require_relative '../lib/router'
require_relative '../controllers/tracks_controllers'

router = Router.new
router.draw do
  get Regexp.new("^/tracks$"), TracksController, :index
  get Regexp.new("^/tracks/new$"), TracksController, :new
  get Regexp.new("^/tracks/(?<id>\\d+)$"), TracksController, :show
  post Regexp.new("^/tracks$"), TracksController, :create
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
