#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MercadoPagoTracker"
  s.version          = "0.5.0"
  s.summary          = "A MercadoPago Tracker SDK."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = "https://github.com/matiasgualino/MercadoPagoTracker"
  s.license          = 'MIT'
  s.author           = { "Matias Gualino" => "matias.gualino@gmail.com" }
  s.source           = { :git => "https://github.com/matiasgualino/MercadoPagoTracker.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'MPTracker/**'

  s.frameworks = 'UIKit', 'CoreData', 'SystemConfiguration', 'Foundation', 'MPGoogleAnalytics'

  s.dependency 'MPGoogleAnalytics'

  s.library = 'z', 'sqlite3'
  
  s.preserve_paths = '**'

  s.vendored_libraries = 'Pods/MPGoogleAnalytics/MPGoogleAnalytics/Classes/libGoogleAnalyticsServices.a'

  other_frameworks =  ['UIKit', 'CoreData', 'SystemConfiguration', 'Foundation', 'MPGoogleAnalytics', 'Pods_MPTracker']

  other_ldflags = '$(inherited) -framework UIKit -framework CoreData -framework SystemConfiguration -framework Foundation -framework MPGoogleAnalytics -lz -lstdc++ -ObjC'

  s.compiler_flags = other_ldflags

  s.xcconfig     = {

    'VALID_ARCHS' => 'armv7 armv7s arm64',

    'OTHER_LDFLAGS[arch=arm64]'  => other_ldflags,
    'OTHER_LDFLAGS[arch=armv7]'  => other_ldflags,
    'OTHER_LDFLAGS[arch=armv7s]' => other_ldflags
  }


end
