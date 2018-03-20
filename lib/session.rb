require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookie_json = {}
    cookies = req.cookies
    cookie = cookies['_rails_lite_app']
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

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie('_rails_lite_app',
    {:path => '/',
      :value => @cookie_json.to_json})
  end
end
