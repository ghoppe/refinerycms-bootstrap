Refinery::Core.configure do |config|
	config.menu_css = {:selected=>"active", :first=>"first", :last=>"last"}
	config.register_stylesheet "refinerycms-bootstrap.css.scss", :media => 'screen' 
end