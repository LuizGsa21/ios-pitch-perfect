//
// Created by Luiz Arantes Sa on 11/5/17.
// Copyright (c) 2017 Luiz Arantes Sa. All rights reserved.
//

import UIKit

extension UIButton {

    public func makeImageResponsive() {
        self.contentMode = .scaleAspectFit
        self.imageView?.contentMode = .scaleAspectFit
    }
}
