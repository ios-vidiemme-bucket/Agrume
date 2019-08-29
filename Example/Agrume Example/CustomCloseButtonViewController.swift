//
//  Copyright © 2018 Schnaub. All rights reserved.
//

import UIKit
import Agrume

final class CustomCloseButtonViewController: UIViewController {
 
  private lazy var agrume: Agrume = {
    let button = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
    button.tintColor = .red
    let buttonShare = UIBarButtonItem(image: UIImage.init(named: "shareicon"), style: .plain, target: nil, action: nil)
    buttonShare.tintColor = .blue
    return Agrume(image: #imageLiteral(resourceName: "MapleBacon"), background: .blurred(.regular), dismissal: .withPhysicsAndButton(button), share: .withButton(buttonShare))
  }()
  
  @IBAction private func showImage() {
    agrume.show(from: self)
  }
  
}
