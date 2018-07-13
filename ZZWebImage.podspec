Pod::Spec.new do |s|

  s.name         = "ZZWebImage"
  s.version      = "1.0.1"
  s.description  = "a simple description"
  s.summary      = 'a simple summary'
  s.homepage     = "https://github.com/ZJamm1993/ZZWebImage"
  s.license      = {:type => 'MIT'}
  s.author       = "ZJamm1993"
  s.source       = { :git => "https://github.com/ZJamm1993/ZZWebImage.git" }
  s.platform = :ios, "8.0"
  s.source_files = "ZZWebImage", "ZZWebImage/Lib/*.{h,m}"
  
end
