Pod::Spec.new do |s|
  s.name         = 'WXInputViewController'
  s.version      = '0.0.1'
  s.license = 'MIT'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/alexiscn/WXInputViewController.git', :tag => s.version.to_s }

  s.summary         = 'WXInputViewController'
  s.homepage        = 'https://github.com/alexiscn/WXInputViewController'
  s.license         = { :type => 'MIT' }
  s.author          = { 'xushuifeng' => 'shuifengxu@gmail.com' }
  s.platform        = :ios
  s.swift_version   = '5.0'
  s.source_files    = 'Sources/**/*.swift'
  s.resource_bundle = { 'Media' => 'Sources/Media.xcassets'}
  s.ios.deployment_target = '12.0'
  
end
