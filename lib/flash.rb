require 'json'

class Flash

  attr_reader :now

  def initialize(req)
    @req = req
    @flash_cookie = {}
    @now = {}
    cookie = req.cookies['_tracks_app_flash']
    if cookie
      @now = JSON.parse(cookie)
      @flash_cookie = JSON.parse(cookie)
    end
  end

  def [](key)
    @flash_cookie[key] || @now[key]
  end

  def []=(key, val)
    @flash_cookie[key] = val
    @flash_cookie[key.to_sym] = @flash_cookie[key]
  end

  def store_flash(res)
    return_cookie = (@flash_cookie.to_a - @now.to_a).to_h
    res.set_cookie('_tracks_app_flash',
    {:path => '/', :value => return_cookie.to_json})
  end


end
