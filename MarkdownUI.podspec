Pod::Spec.new do |s|
  s.name             = 'MarkdownUI'
  s.version          = '1.0.0'
  s.summary          = 'Render Markdown in SwiftUI.'
  s.description      = <<-DESC
                       A SwiftUI library for rendering Markdown content,
                       supporting images, code blocks, and tables.
                       DESC

  s.homepage         = 'https://github.com/Peterfelee/swift-markdown-ui.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Peterfelee' => 'peterfelee@gmail.com' }
  
  s.source           = { :git => 'https://github.com/Peterfelee/swift-markdown-ui.git', :tag => s.version.to_s }

  s.swift_version = '5.6'
  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'
  # s.tvos.deployment_target = '15.0'
  # s.watchos.deployment_target = '8.0'

  # 1. 包含所有源码文件（Swift、C、头文件和包含文件）
  s.source_files = [
    'Sources/MarkdownUI/**/*.swift',
    'Sources/MarkdownUI/Cmake/src/*.c',
    'Sources/MarkdownUI/Cmake/src/*.inc',
    'Sources/MarkdownUI/Cmake/src/include/*.h',
    'Sources/MarkdownUI/Cmake/extensions/*.c',
    'Sources/MarkdownUI/Cmake/extensions/*.h',
    'Sources/MarkdownUI/Cmake/extensions/include/*.h'
  ]
  
  # 2. 排除不需要的文件
  s.exclude_files = [
    'Sources/MarkdownUI/**/CMakeLists.txt',
    'Sources/MarkdownUI/**/*.in',
    'Sources/MarkdownUI/**/*.re',
    'Sources/MarkdownUI/**/*.sh',
    'Sources/MarkdownUI/**/*.md',
    'Sources/MarkdownUI/Cmake/fuzz/**/*',
    'Sources/MarkdownUI/Documentation.docc/**/*'
  ]

  # 3. 暴露 C 语言头文件（必须在 source_files 中）
  s.public_header_files = [
    'Sources/MarkdownUI/Cmake/src/include/*.h',
    'Sources/MarkdownUI/Cmake/extensions/include/*.h'
  ]

  # 4. 保留 module.modulemap 文件路径（重要：Swift 需要它来导入 C 模块）
  s.preserve_paths = [
    'Sources/MarkdownUI/Cmake/src/include/module.modulemap',
    'Sources/MarkdownUI/Cmake/extensions/include/module.modulemap'
  ]

  # 5. 头文件搜索路径和编译配置
  s.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => [
      '"$(PODS_TARGET_SRCROOT)/Sources/MarkdownUI/Cmake/src/include"',
      '"$(PODS_TARGET_SRCROOT)/Sources/MarkdownUI/Cmake/src"',
      '"$(PODS_TARGET_SRCROOT)/Sources/MarkdownUI/Cmake/extensions/include"',
      '"$(PODS_TARGET_SRCROOT)/Sources/MarkdownUI/Cmake/extensions"'
    ].join(' '),
    'SWIFT_INCLUDE_PATHS' => [
      '$(PODS_TARGET_SRCROOT)/Sources/MarkdownUI/Cmake/src/include',
      '$(PODS_TARGET_SRCROOT)/Sources/MarkdownUI/Cmake/extensions/include'
    ].join(' '),
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) CMARK_GFM_STATIC_DEFINE=1',
    'OTHER_CFLAGS' => '$(inherited) -fno-modules'
  }

  s.library = 'c++'
end