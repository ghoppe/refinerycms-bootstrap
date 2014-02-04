module BootstrapHelper
  def glyph(*names)
    content_tag :span, nil, class: names.map{|name| "glyphicon-#{name.to_s.gsub('_','-')}" }.unshift('glyphicon').join(' ')
  end
end