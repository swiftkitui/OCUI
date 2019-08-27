Pod::Spec.new do |spec|
spec.name         = "CombineObjectObjc"
  spec.version      = "1.0.0"
  spec.summary      = "CombineObject 响应式框架的 Objective-C 版本"
  spec.homepage     = "https://github.com/combineobject/CombineObject-Objc"
  spec.license      = "MIT"
  spec.author             = { "张行" => "zhanghang@globalegrow.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/combineobject/CombineObject-Objc.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources", "Sources/**/*.{h,m}"
end
