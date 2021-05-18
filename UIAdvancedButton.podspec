Pod::Spec.new do |spec|
spec.name          = "UIAdvancedButton"
spec.version       = "1.1.0"
spec.summary       = "An efficient and accessible button, with different styles and parameters, written in Swift 5."
spec.homepage      = "https://github.com/stevensyp/UIAdvancedButton"
spec.license       = { :type => "MIT", :file => "LICENSE" }
spec.author        = { "author" => "Steven Syp" }
spec.platforms     = { :ios => "13.0" }
spec.source        = { :git => "https://github.com/stevensyp/UIAdvancedButton.git", :tag => "#{spec.version}" }
spec.source_files  = "UIAdvancedButton/**/*.swift"
spec.swift_version = "5.3"
end
