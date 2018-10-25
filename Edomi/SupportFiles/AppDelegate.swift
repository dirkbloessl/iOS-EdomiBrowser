import UIKit
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var idleTimer: Timer?
    var totalTime = 60
    
    static var defaultBrightNess : CGFloat = 0.5;

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationDidTimeout(notification:)),
                                               name: .appTimeout,
                                               object: nil
        )
        // disable iOS idle timeout
        UIApplication.shared.isIdleTimerDisabled = true
        
        //save last brightness
        AppDelegate.defaultBrightNess = UIScreen.main.brightness;

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    class func resetBrightness() {
        UIScreen.main.brightness = CGFloat(AppDelegate.defaultBrightNess)
        UIScreen.main.wantsSoftwareDimming = false
    }
    
    class func disableScreen() {
        UIScreen.main.brightness = CGFloat(0.0)
        UIScreen.main.wantsSoftwareDimming = true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        AppDelegate.resetBrightness()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func applicationDidTimeout(notification: NSNotification) {
        let popUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpVc") as! PopUpViewController
        let mainWindow = self.window!.rootViewController!
        mainWindow.addChild(popUpVc)
        popUpVc.view.frame = mainWindow.view.frame
        mainWindow.view.addSubview(popUpVc.view)
        popUpVc.didMove(toParent: mainWindow)
    }
}
