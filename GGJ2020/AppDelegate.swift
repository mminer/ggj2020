import ARKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard ARWorldTrackingConfiguration.isSupported else {
            fatalError("ARKit is unavailable on this device.")
        }

        return true
    }
}
