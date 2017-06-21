
Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "SJLineRefresh"
  s.version      = "1.0.1"
  s.summary      = "A easy customizable shape pull-to-refresh view in UIScrolView."


  s.description  = <<-DESC
                    A pull-to-refresh control that you could use your own share easily.
                   DESC

  s.homepage     = "https://github.com/515783034/SJLIineRefresh"
  s.screenshots  = "http://upload-images.jianshu.io/upload_images/988961-5f6cc8c69fead46f.gif?imageMogr2/auto-orient/strip"

  s.license      = "MIT"

  s.author             = { "shmily" => "shmilyshijian@foxmail.com" }
  s.social_media_url   = "http://www.jianshu.com/u/3095a094665c"

  s.platform     = :ios, "9.0"


  s.source       = { :git => "https://github.com/515783034/SJLIineRefresh.git", :tag => "#{s.version}" }

  s.source_files  = "SJLineRefresh/Sources/*.swift"

  s.resources = "SJLineRefresh/Resources/*.*"

  s.requires_arc = true

end
