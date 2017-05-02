#
#  Be sure to run `pod spec lint ProtocolOrientedViewModel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "ProtocolOrientedViewModel"
  s.version      = "0.0.1"
  s.summary      = "Create universal view's with different layouts for each platform and share the view logic between them."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
ProtocolOrientedViewModel
===

Create universal view's with different layouts for each platform and share the view logic between them.

Requirements
----

- Swift 3.0+
- iOS 8.0+
- tvOS 9.0+
- macOS 10.10+

Install
----

```
pod 'ProtocolOrientedViewModel'
```

Usage
----

This is most useful for universal ios/tvos/mac projects.
Create `Layout`s for your view. For example, portrait and landscape.
Create xib's for each layout of each platform or just create them programmaitaclly.

```
enum HomeScreenLayout: Layout {
case portrait
case landscape

// Define the type of view
typealias View = HomeScreenView
var view: HomeScreenView? {
return from xib or create and return them here for each layout.
}
}
```

Create your view and its delegate with actions.

```
protocol HomeScreenViewDelegate: class {
func homeScreenViewDidPressSomething(_ homeScreenView: HomeScreenView)
...
}

class HomeScreenView: POView { // POView is a typealias of NSView and UIView for sharing view.
weak var delegate: HomeScreenViewDelegate?
@IBOutlet var someLabel: UILabel?

@IBAction func somethingDidPress() {
delegate?.homeScreenViewDidPressSomething(self)
}

...
}
```

And create your view model

```
class HomeScreenViewModel: ViewModel, HomeScreenViewDelegate {

// MARK: ViewModel
// define the type of view
typealias View = HomeScerenView
var view: HomeScrenView?

// Make your updates for your view.
func render() {
view?.someLabel?.text = dataSource.someValue
view?...
}

// MARK: HomeScreenViewDelegate
func homeScreenViewDidPressSomething(_ homeScreenView: HomeScreenView) {
dataSource.someValue = "new value"
render()
}

...
}
```

Call `updateLayoutFor:InView:` function on the view model to update layout of your view.
Also see the example project for universal usage with multiple layouts with xibs in multiple platforms.
                   DESC

  s.homepage     = "https://github.com/cemolcay/ProtocolOrientedViewModel"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "cemolcay" => "ccemolcay@gmail.com" }
  # Or just: s.author    = "cemolcay"
  # s.authors            = { "cemolcay" => "ccemolcay@gmail.com" }
  s.social_media_url   = "http://twitter.com/cemolcay"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  # s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/cemolcay/ProtocolOrientedViewModel.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Source/*.swift"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
