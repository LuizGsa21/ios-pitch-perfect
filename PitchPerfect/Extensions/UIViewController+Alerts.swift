//
// Created by Luiz Arantes Sa on 11/5/17.
// Copyright (c) 2017 Luiz Arantes Sa. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: Generic Alerts

    struct Alerts {
        static let DismissAlert = "Dismiss"
    }

    public func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
