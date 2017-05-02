//
//  ProtocolOrientedViewModel.swift
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

#if os(iOS) || os(tvOS)
  public typealias POView = UIView
#elseif os(OSX)
  public typealias POView = NSView
#endif

/// Define your layouts with an enum that conforms Layout protocol.
public protocol Layout {

  /// The type of your view that you want to layout. It should be UIView/NSView or one of their subclass.
  associatedtype ViewType: POView

  /// View references for different `Layout`s. You probably want to use sepearate xib's for each Layout. Or you could create and return them programmatically in this function.
  var view: ViewType? { get }
}

/// Define your view models with a class that conforms ViewModel protocol.
public protocol ViewModel {

  /// The type of your view that you want to model out. It should be UIView/NSView or one of their subclass.
  associatedtype ViewType: POView
  associatedtype LayoutType: Layout

  /// Reference of the view of view model. It will be populated from `getView:ForLayout` function.
  var view: ViewType? { get set }

  /// Current `view`'s render/update function. Implement this for your view's data rendering. It will be get called automatically when layout changes.
  func render(layout: LayoutType?)
}

extension ViewModel {

  /// Updates current layout with new layout inside the view you want to layout. It's usually the `view` property of view controller. It removes all other previous subviews and adds the layout's view `in view`. Also, adds left, right, top and bottom constraints with 0 constant.
  ///
  /// - Parameters:
  ///   - layout: New layout.
  ///   - view: Superview of laying out view. It's usually view controller's view property.
  public mutating func updateLayout<L: Layout>(for layout: L, in view: POView) where L == LayoutType {
    guard let layoutView = layout.view as? ViewType else { return }
    view.subviews.forEach{ $0.removeFromSuperview() }
    view.addSubview(layoutView)

    layoutView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: layoutView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: layoutView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: layoutView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: layoutView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
    ])

    self.view = layoutView
    render(layout: layout)
  }
}
