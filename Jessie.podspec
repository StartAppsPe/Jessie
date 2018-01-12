
Pod::Spec.new do |s|

s.name             = 'Jessie'
s.version          = '2.6.3'
s.summary          = 'A simple JSON parsing library designed for swift. It is type safe and simple to use.'
s.description      = <<-DESC
A simple JSON parsing library designed for swift. Inspired by the simplicity of SwiftyJSON but with type safe methods.
DESC
s.homepage         = 'https://github.com/StartAppsPe/'+s.name
s.license          = 'MIT'
s.author           = { 'Gabriel Lanata' => 'gabriellanata@gmail.com' }

s.source           = { :git => 'https://github.com/StartAppsPe/'+s.name+'.git', :tag => s.version.to_s }
s.module_name      = s.name
s.requires_arc     = true

s.ios.deployment_target  = '8.0'
s.osx.deployment_target  = '10.10'

s.source_files     = 'Sources'

end
