# Uncomment this line to define a global platform for your project
#platform :ios, ‘8.0’

use_frameworks!

pre_install do |pre_i|
    def pre_i.verify_no_static_framework_transitive_dependencies; end
end

target 'MPTracker' do
	pod 'MPGoogleAnalytics', '0.2.0'
end
