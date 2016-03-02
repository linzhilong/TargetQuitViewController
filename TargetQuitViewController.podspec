Pod::Spec.new do |s|
  s.name         = "TargetQuitViewController"
  s.version      = "0.0.1"
  s.summary      = "Back to target quit viewController animatable."

  s.description = %{
     Sometimes we have to back to a specified viewController, then we can use this lib, tag a target quit viewController, and then back to it animatable. 
  }	
  s.homepage     = "https://github.com/linzhilong/TargetQuitViewController"


  s.license      = "MIT"

  s.author             = { "zhilong lin" => "26724627@qq.com" }

  s.source       = { :git => "https://github.com/linzhilong/TargetQuitViewController.git", :tag => "0.0.1" }


  s.source_files  = "*.{h,m}"

  s.ios.frameworks = 'Foundation', 'UIKit'
  s.ios.deployment_target = '6.0'

  s.requires_arc = true

end
