class Static

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    res = app.call(env)
    assets = request.match()
  end
end
