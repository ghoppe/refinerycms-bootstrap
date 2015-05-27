module BootstrapHelper
  def glyph(*names)
    content_tag :span, nil, class: names.map{|name| "glyphicon-#{name.to_s.gsub('_','-')}" }.unshift('glyphicon').join(' ')
  end

  def alert_class(*key)
    base_class = "alert"
    case key
    when 'alert'
      base_class << " alert-warning"
    when 'notice'
      base_class << " alert-success"
    when 'error'
      base_class << " alert-danger"
    else
      base_class << " alert-info"
    end
    base_class
  end
end
