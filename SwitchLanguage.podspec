Pod::Spec.new do |s|
  s.name = 'SwitchLanguage'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Manage translation easily in your app'
  s.homepage = 'https://github.com/NicolasPoincet/SwitchLanguage'
  s.authors = { 'Nicolas Poincet' => '', '' => '', '' => ''  }
  s.source = { :git => 'https://github.com/NicolasPoincet/SwitchLanguage.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'CIFramework/*.swift'
end