
Pod::Spec.new do |s|

  s.name         = "jiangchaoRACDemo"
  s.version      = "0.0.1"
  s.summary      = "嗯"

  s.homepage     = "https://github.com/jiangchao829/jiangchaoRACDemo"

  s.license      = "MIT"
  s.author             = { "jiangchao829" => "email@address.com" }
   s.platform     = :ios, "8.0"

   s.source       = { :git => "https://github.com/jiangchao829/jiangchaoRACDemo.git", :tag => s.version }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true

end
