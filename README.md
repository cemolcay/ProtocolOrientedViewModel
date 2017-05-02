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
use_frameworks!
pod 'ProtocolOrientedViewModel'
```

Usage
----

This is most useful for universal ios/tvos/mac projects.  
Create `Layout`s for your view. For example, portrait and landscape.  
Create xib's for each layout of each platform or just create them programmaitaclly.

``` swift
enum HomeScreenLayout: Layout {
  case portrait
  case landscape

  // Define the type of view
  typealias ViewType = HomeScreenView
  var view: HomeScreenView? {
    // return from xib or create and return them here for each layout.
  }
}
```

Create your view and its delegate with actions.

``` swift
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

``` swift
class HomeScreenViewModel: ViewModel, HomeScreenViewDelegate {

  // MARK: ViewModel
  // define the type of view
  typealias ViewType = HomeScerenView
  var view: HomeScrenView?

  // Make your updates for your view.
  typealias LayoutType = ExampleLayout
  func render(layout: ExampleLayout?) {
    view?.someLabel?.text = dataSource.someValue
    view?...

    if let layout = layout, case .portrait = layout {
      // Do layout specific stuff.
    }
  }

  // MARK: HomeScreenViewDelegate
  func homeScreenViewDidPressSomething(_ homeScreenView: HomeScreenView) {
    dataSource.someValue = "new value"
    render(layout: nil)	
  }

  ...
}
```

Call `updateLayoutFor:InView:` function on the view model to update layout of your view.  
Also see the example project for universal usage with multiple layouts with xibs in multiple platforms.
