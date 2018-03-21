require 'json'

class Session
  def initialize(req)
    @cookie_json = {}
    cookies = req.cookies
    cookie = cookies['_tracks_app']
    if cookie
      @cookie_json = JSON.parse(cookie)
    end
  end

  def [](key)
    @cookie_json[key]
  end

  def []=(key, val)
    @cookie_json[key] = val
  end

  def store_session(res)
    res.set_cookie('_tracks_app',
    {:path => '/',
      :value => @cookie_json.to_json})
  end
end
