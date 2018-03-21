require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = route_params.merge(req.params)
  end

  def already_built_response?
    !!@already_built_response
  end

  def redirect_to(url)
    raise "Double Render Error" if already_built_response?
    res.header['location'] = url
    res.status = 302
    @already_built_response = true
    session.store_session(@res)
  end

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

  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end

  def invoke_action(name)
    self.send(name.to_sym)
    render(name) unless already_built_response?
  end

end
