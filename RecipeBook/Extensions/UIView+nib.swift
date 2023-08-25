import UIKit

extension UIView {
    class var className: String {
        return String(describing: self)
    }

    class var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
