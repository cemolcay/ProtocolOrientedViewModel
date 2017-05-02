//
//  ExampleViewModel.swift
//  ProtocolOrientedViewModel
//
//  Created by Cem Olcay on 01/05/2017.
//
//

#if os(iOS) || os(tvOS)
  import UIKit
#elseif os(OSX)
  import AppKit
#endif
import ProtocolOrientedViewModel

#if os(iOS) || os(tvOS)
  typealias POViewController = UIViewController
#elseif os(OSX)
  typealias POViewController = NSViewController
#endif

// All of your layouts for a view type, goes here.
enum ExampleLayout: Layout {
  case portrait
  case landscape

  typealias View = ExampleView
  var view: ExampleView? {
    switch self {
    case .portrait:
      #if os(iOS) || os(tvOS)
        return Bundle.main.loadNibNamed("Portrait", owner: nil, options: nil)?.first as? ExampleView
      #elseif os(OSX)
        var nib = NSArray()
        if Bundle.main.loadNibNamed("Portrait", owner: nil, topLevelObjects: &nib) {
          return nib.firstObject as? ExampleView
        }
        return nil
      #endif

    case .landscape:
      #if os(iOS) || os(tvOS)
        return Bundle.main.loadNibNamed("Landscape", owner: nil, options: nil)?.first as? ExampleView
      #elseif os(OSX)
        var nib = NSArray()
        if Bundle.main.loadNibNamed("Landscape", owner: nil, topLevelObjects: &nib) {
          return nib.firstObject as? ExampleView
        }
        return nil
      #endif
    }
  }
}

// All of actions of your view goes here, and implement them in the view model.
protocol ExampleViewDelegate: class {
  func exampleViewDidPressButton(_ exampleView: ExampleView)
}

// You need to sepearate ios/tvos and mac view classes in order to use them inside xibs properly due to an interface builder bug.
#if os(iOS) || os(tvOS)
  class ExampleView: UIView {
    weak var delegate: ExampleViewDelegate?

    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var label: UILabel?

    @IBAction func buttonDidPress(sender: Any) {
      delegate?.exampleViewDidPressButton(self)
    }
  }
#elseif os(OSX)
  class ExampleView: NSView {
    weak var delegate: ExampleViewDelegate?

    @IBOutlet weak var button: NSButton?
    @IBOutlet weak var label: NSTextField?

    @IBAction func buttonDidPress(sender: Any) {
      delegate?.exampleViewDidPressButton(self)
    }
  }
#endif

// Share the single view model class between all platforms. Create your UI in xibs even with different layouts.
class ExampleViewModel: ViewModel, ExampleViewDelegate {
  var dataSource = ["date": Date()]

  // MARK: ViewModel

  typealias View = ExampleView
  var view: ExampleView? {
    didSet {
      view?.delegate = self
    }
  }

  func render() {
    #if os(iOS) || os(tvOS)
      view?.label?.text = "\(dataSource["date"]!)"
    #elseif os(OSX)
      view?.label?.stringValue = "\(dataSource["date"]!)"
    #endif
  }

  // MARK: ExampleViewDelegate

  func exampleViewDidPressButton(_ exampleView: ExampleView) {
    dataSource["date"] = Date()
    render()
  }
}

// You can even share the view controller if you want.
class ExampleViewController: POViewController {
  var viewModel = ExampleViewModel()
  var currentLayout: ExampleLayout?

  override func viewDidLoad() {
    super.viewDidLoad()
    updateLayout()
  }

  #if os(iOS) || os(tvOS)
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
      updateLayout()
    }
  #elseif os(OSX)
    override func viewDidLayout() {
      super.viewDidLayout()
      updateLayout()
    }
  #endif

  // Just a dummy layout state machine
  func getLayoutForState() -> ExampleLayout {
    if view.bounds.size.height > view.bounds.size.width {
      return .portrait
    } else {
      return .landscape
    }
  }

  func updateLayout() {
    let layout = getLayoutForState()
    if let currentLayout = currentLayout, currentLayout == layout {
      return
    }
    currentLayout = layout
    viewModel.updateLayout(for: layout, in: view)
  }
}
