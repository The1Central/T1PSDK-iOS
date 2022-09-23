Pod::Spec.new do |spec|
  spec.name         = "T1PSDK"
  spec.version      = "1.2.7"
  spec.summary      = "T1PSDK"
  spec.description  = "T1PSDK"
  spec.homepage     = "https://github.com/The1Central/The1-T1PSDK-iOS"
  spec.license      = "All Right Reserved"
  spec.author       = "THE 1 CENTRAL COMPANY LIMITED"
  spec.platform     = :ios, "11.0"
  spec.ios.deployment_target = "11.0"
  spec.swift_version = '5'
  spec.source       = { :git => "https://github.com/The1Central/T1PSDK-iOS.git", :tag => "1.2.7"  }
  spec.default_subspec = 'Core'
  spec.vendored_frameworks = "T1PSDK.xcframework"

  spec.subspec 'Core' do |ss|
      ss.dependency 'Moya'
      ss.dependency "CryptoSwift"
      ss.dependency 'SwiftLint'
      ss.dependency 'SwiftFormat/CLI'
      ss.dependency 'SwiftKeychainWrapper'
  end
end
