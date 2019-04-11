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

  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Close", for: .normal)
    button.setImage(nil, for: .normal)
    button.usesAutoLayout(true)
    return button
  }()
  
  private lazy var shareButton: UIButton = {
    let button = UIButton(type: .custom)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Share", for: .normal)
    button.setImage(nil, for: .normal)
    button.usesAutoLayout(true)
    return button
  }()
  
  init(closeButton: UIButton?, shareButton: UIButton?) {
    super.init(frame: .zero)

    /*Close Button*/
    if let closeButton = closeButton {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton = closeButton
    }
    
    addSubview(self.closeButton)
    
    self.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      self.closeButton.topAnchor.constraint(equalTo: portableSafeTopInset),
      self.closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
      ])
    
    /*Share Button*/
    if let shareButton = shareButton {
      shareButton.translatesAutoresizingMaskIntoConstraints = false
      self.shareButton = shareButton
    }
    
    addSubview(self.shareButton)
    
    self.shareButton.addTarget(self, action: #selector(share), for: .touchUpInside)
    
    NSLayoutConstraint.activate([
      self.shareButton.topAnchor.constraint(equalTo: portableSafeTopInset),
      self.shareButton.trailingAnchor.constraint(equalTo: self.closeButton.leadingAnchor, constant: -10)
      ])
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
