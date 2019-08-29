//
//  Copyright © 2018 Schnaub. All rights reserved.
//

import UIKit

protocol AgrumeOverlayViewDelegate: AnyObject {
  func agrumeOverlayViewWantsToClose(_ view: AgrumeOverlayView)
  func agrumeOverlayViewWantsToShare(_ view: AgrumeOverlayView)
}

final class AgrumeOverlayView: UIView {
  
  weak var delegate: AgrumeOverlayViewDelegate?

  private lazy var navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    navigationBar.usesAutoLayout(true)
    navigationBar.backgroundColor = .clear
    navigationBar.shadowImage = UIImage()
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.items = [navigationItem]
    return navigationBar
  }()

  private lazy var navigationItem = UINavigationItem(title: "")
  private lazy var defaultCloseButton = UIBarButtonItem(title: NSLocalizedString("Close", comment: "Close image view"),
                                                        style: .plain, target: self, action: #selector(close))

  var publicShareButton: UIBarButtonItem?
  
  init(closeButton: UIBarButtonItem?, shareButton: UIBarButtonItem?) {
    super.init(frame: .zero)

    addSubview(navigationBar)

    /*Close Button*/
    if let closeButton = closeButton {
        closeButton.target = self
        closeButton.action = #selector(close)
    }

    /*Share Button*/
    if let shareButton = shareButton {
      shareButton.target = self
      shareButton.action = #selector(share)
      publicShareButton = shareButton
    }

    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: portableSafeTopInset),
      navigationBar.widthAnchor.constraint(equalTo: widthAnchor),
      navigationBar.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])

    navigationItem.rightBarButtonItems = [closeButton ?? defaultCloseButton, shareButton].compactMap{$0}

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if let view = super.hitTest(point, with: event), view != self {
      return view
    }
    return nil
  }
  
  @objc
  private func close() {
    delegate?.agrumeOverlayViewWantsToClose(self)
  }
  
  @objc
  private func share() {
    delegate?.agrumeOverlayViewWantsToShare(self)
  }
  
}
