import UIKit

class DeeplinkNavigator {
    
    static func navigate(with deepLinkParam: String) {
        guard
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
            let navigationController = window.rootViewController as? UINavigationController else { return }
        
        navigationController.pushViewController(
            TestViewController(with: deepLinkParam), animated: true
        )
    }
}
