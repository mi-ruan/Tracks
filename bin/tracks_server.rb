require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'
require_relative 'track'

class TracksController < ControllerBase

  def create
    @track = Track.new(params["track"])
    if @track.save
      flash[:notice] = "Added track successfully"
      redirect_to "/tracks"
    else
      flash.now[:errors] = @track.errors
      render :new
    end
  end

  def index
    @tracks = Track.all
    render :index
  end

  def new
    @track = Track.new
    render :new
  end

  def show
    @track = Track.find(params["track"])
    render :show
  end
end

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
