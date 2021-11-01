#
# Be sure to run `pod lib lint Appointments.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'Appointments'
    s.version          = '0.0.2-rc.41'
    s.summary          = 'Appointment pod for iOS Apps'
    
    s.description      = <<-DESC
    Integrating it into any app will allow user of the App to see and mark appointments.
    DESC
    
    s.homepage         = 'https://caremerge.com'
    s.license          = { :type => 'Caremerge', :file => 'LICENSE' }
    s.author           = { 'Muhammad Hussaan Saeed' => 'hussaan.saeed@careaxiom.com' }
    s.source           = { :git => 'git@github.com:caremerge/appointments-ios.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '12.1'
    s.swift_version = '5'
    
    s.source_files = 'Appointments/Source/**/*.{h,m,swift}'
    s.resources = 'Appointments/**/*.{xcdatamodeld,xcassets}'

    s.frameworks = 'UIKit'
    s.dependency 'RxSwift', '6.2.0'
    s.dependency 'RxCocoa', '6.2.0'
    s.dependency 'RxSwiftExt', '6.0.1'
    s.dependency 'Alamofire'
    s.dependency 'Kingfisher'
    s.dependency 'SVProgressHUD'
    
end
