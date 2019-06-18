//
//  Copyright © 2018 Schnaub. All rights reserved.
//

import UIKit
import Agrume

final class CustomCloseButtonViewController: UIViewController {
 
  private lazy var agrume: Agrume = {
    let button = UIButton(type: .custom)
    button.tintColor = .red
    button.setImage(UIImage.init(named: "navbar_close_white_shadow"), for: .normal)
    let buttonShare = UIButton(type: .custom)
    buttonShare.tintColor = .red
    buttonShare.setImage(UIImage.init(named: "shareicon"), for: .normal)
    return Agrume(image: #imageLiteral(resourceName: "MapleBacon"), background: .blurred(.regular), dismissal: .withPhysicsAndButton(button), share: .withButton(buttonShare))
  }()
  
  @IBAction private func showImage() {
    agrume.show(from: self)
  }
  
}
