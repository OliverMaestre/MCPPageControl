Pod::Spec.new do |spec|
  spec.name         = 'MCPPageControl'
  spec.homepage		= "https://bitbucket.org/Machipla/mcppods"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }	
  spec.version      = '1.3.1'
  spec.platform 	= :ios, "6.0"
  spec.authors      = { 'Mario Chinchilla' => 'mario.chinchilla.plaza@gmail.com' }
  spec.summary      = 'Page Control con protocolo para establecer en una tabla, scroll o colección con paginación'
  spec.source       = { :git => 'http://gitlab.planetmedia.es/Pods/MCPPageControl.git', :tag => "#{spec.version}" }
  spec.source_files = "*.{h,m}"

  spec.dependency 'MCPCategories'
end