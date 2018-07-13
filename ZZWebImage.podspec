Pod::Spec.new do |s|

#   s.name         = "ZZWebImage"
#   s.version      = "1.0.1"
#   s.description  = "a simple description"
#   s.summary      = 'a simple summary'
#   s.homepage     = "https://github.com/ZJamm1993/ZZWebImage"
#   s.license      = {:type => 'MIT'}
#   s.author       = "ZJamm1993"
#   s.source       = { :git => "https://github.com/ZJamm1993/ZZWebImage.git" }
#   s.platform = :ios, "8.0"
#   s.source_files = "ZZWebImage", "ZZWebImage/Lib/*.{h,m}"

  #new
  s.name                = "ZZWebImage"
  s.version             = "1.0.1"
  s.summary             = "a simple description"
  s.homepage            = "https://github.com/ZJamm1993/ZZWebImage"
  s.license             = { :type => "MIT", :file => "LICENNSE" }
  s.author              = { "ZJamm1993" => "670231925@qq.com" }
  s.platform            = :ios, '8.0'
  s.source              = {:git => "https://github.com/ZJamm1993/ZZWebImage.git"}
  s.source_files        = "ZZWebImage/Lib", "ZZWebImage/Lib/*.{h,m}"
  s.requires_arc        = true
  
end
