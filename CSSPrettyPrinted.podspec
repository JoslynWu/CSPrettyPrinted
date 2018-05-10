Pod::Spec.new do |s|
  s.name         = "CSSPrettyPrinted"
  s.version      = "0.1.0"
  s.summary      = "一个带层级标记的支持中文的控制台打印。"
  s.license      = { :type => 'MIT License', :file => 'LICENSE' }
  s.authors      = { 'Joslyn' => 'cs_joslyn@foxmail.com' }
  s.homepage     = 'https://github.com/JoslynWu/CSSPrettyPrinted'
  s.social_media_url   = "http://www.jianshu.com/u/fb676e32e2e9"
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/JoslynWu/CSSPrettyPrinted.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'CSSPrettyPrinted/*.{h,m}'
  s.public_header_files = 'CSSPrettyPrinted/*.{h}'
end
