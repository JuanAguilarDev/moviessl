# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '14.0'

inhibit_all_warnings!

target 'moviessl' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for moviessl
  pod 'IQKeyboardManagerSwift'
  pod 'Alamofire', '~> 5.0'
  pod 'ObjectMapper', '~> 4.2'
  pod 'KVNProgress'
  pod 'MaterialComponents'
  pod 'SQLite.swift', '~> 0.12.0'
  pod 'FMDB'

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
            end
        end
    end
end
