Pod::Spec.new do |s|
  s.name         = "ReactiveCocoa"
  s.version      = "20.1.0"
  s.summary      = "Streams of values over time"
  s.description  = <<-DESC
                   ReactiveCocoa (RAC) is a Cocoa framework built on top of ReactiveSwift. It provides APIs for using ReactiveSwift with Apple's Cocoa frameworks.
                   DESC
  s.homepage     = "https://github.com/ReactiveCocoa/ReactiveCocoa"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "ReactiveCocoa"

  s.ios.deployment_target = "12.0"
  s.tvos.deployment_target = "12.0"

  s.source       = { :git => "https://github.com/kyanosq/ReactiveCocoa.git", :tag => "#{s.version}" }
  s.source_files = "ReactiveCocoa/*.{swift,h,m}", "ReactiveCocoa/Shared/*.{swift}", "ReactiveCocoaObjC/**/*.{h,m}"
  
  s.resource_bundles = {"ReactiveCocoa" => ["ReactiveCocoa/PrivacyInfo.xcprivacy"]}

  
  s.public_header_files = "ReactiveCocoaObjC/include/ObjCRuntimeAliases.h"
  s.ios.source_files = "ReactiveCocoa/UIKit/*.{swift}", "ReactiveCocoa/UIKit/iOS/*.{swift}"
  s.tvos.source_files = "ReactiveCocoa/UIKit/*.{swift}"
  s.module_name = 'ReactiveCocoa'

  s.dependency 'ReactiveSwift', '~> 10.1.0'

  s.pod_target_xcconfig = { "OTHER_SWIFT_FLAGS[config=Release]" => "$(inherited) -suppress-warnings" }
  s.swift_version = '5.0'
end
