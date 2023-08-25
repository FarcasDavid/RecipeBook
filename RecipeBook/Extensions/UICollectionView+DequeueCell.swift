import UIKit

extension UICollectionView {

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.className,
            for: indexPath
        ) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(T.className)")
        }
        return cell
    }
}
