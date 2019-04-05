
Pod::Spec.new do |spec|
spec.name             = 'PageViewV'
spec.version          = '0.1.0'
spec.license          = { :type => "MIT", :file => "LICENSE" }
spec.homepage         = 'https://github.com/QuocNguyen0909/PageViewV'
spec.authors          = { 'Quoc Nguyen' => 'nguyenvanquoc090997@gmail.com' }
spec.summary          = 'AAn infinite scrolling control inspired by PageViewController.'
spec.source           = { :git => 'https://github.com/QuocNguyen0909/PageViewV.git', :tag => 'spec.version' }
spec.source_files     = 'PageViewV.h,m'
spec.framework        = 'SystemConfiguration'
spec.requires_arc     = true
spec.swift_version = "5.0"
end
