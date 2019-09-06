Pod::Spec.new do |s|
s.name         = 'BlueConnentTool'
s.version      = '1.0.2'
s.summary      = '网页封装'
s.homepage     = 'https://github.com/CodingHero520/BlueConnentTool.git'
s.license      = 'MIT'
s.authors      = {'包磊' => '2406934820@qq.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/CodingHero520/BlueConnentTool.git', :tag => s.version}
s.source_files = 'BBWKWebView/**/*'
s.requires_arc = true
end