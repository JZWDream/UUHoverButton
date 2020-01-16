
Pod::Spec.new do |s|

s.name = "UUHoverButton"
s.version = "0.0.1"
s.summary = "UUHoverButton."
s.description = <<-DESC
一个简单的悬浮球按钮，可以自由拖动，静置自动吸附边缘
DESC

s.homepage = "https://github.com/JZWDream/UUHoverButton"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "JZWDream" => "wangdi1418278738@163.com" }
s.platform = :ios, "8.0"
s.source = { :git => "https://github.com/JZWDream/UUHoverButton.git", :tag => "#{s.version}" }
s.source_files = "UUHoverButton", "UUHoverButton/**/*.{h,m}"

end
