Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "HSSearchable"
s.summary = "The easiest way to search from UITableView using UISearchBar or UISearchBarController in the minimum line of code."
s.requires_arc = true

# 2
s.version = "1.0.2"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Hitendra Solanki" => "hitendra.developer@gmail.com" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/hitendradeveloper/HSSearchable"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/hitendradeveloper/HSSearchable.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

# 8
s.source_files = "HSSearchable/**/*.{swift}"

# 9
#s.resources = "HSSearchable/**/*.{png,jpeg,jpg,storyboard,xib}"
end
