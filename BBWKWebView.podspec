Pod::Spec.new do |s|
s.name         = 'BBWKWebView'
s.version      = '1.0.0'
s.summary      = '网页封装'
s.homepage     = 'https://github.com/CodingHero520/BBWKWebView'
s.license      = 'MIT'
s.authors      = {'包磊' => '2406934820@qq.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/CodingHero520/BBWKWebView', :tag => s.version}
s.source_files = 'BBWKWebView/**/*'
s.requires_arc = true
end