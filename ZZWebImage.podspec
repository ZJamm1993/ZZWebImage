Pod::Spec.new do |s|

  s.name         = "ZZWebImage"
  s.version      = "1.0"
  s.summary      = "A short description of ZZWebImage."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/ZJamm1993/ZZWebImage"
  s.license      = "MIT (example)"
  s.author       = "ZJamm1993"
  s.source       = { :git => "https://github.com/ZJamm1993/ZZWebImage.git", :tag => "#{s.version}" }
  s.source_files  = "ZZWebImage", "ZZWebImage/Lib/*.{h,m}"
  s.frameworks   = 'UIKit','Foundation'
  
end
