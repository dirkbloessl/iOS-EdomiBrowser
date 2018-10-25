import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(WebViewController.defaultsChanged),
                                               name: UserDefaults.didChangeNotification,
                                               object: nil
        )
        defaultsChanged()
        loadUrl()
    }
    
    func loadUrl()
    {
        let urlString = UserDefaults.standard.string(forKey: "edomi_url")! + "?visu="
            + UserDefaults.standard.string(forKey: "edomi_visu_id")!
            + "&login=" + UserDefaults.standard.string(forKey: "edomi_visu_login")!
            + "&pass=" + UserDefaults.standard.string(forKey: "edomi_visu_password")!
        let url = URL(string: urlString)!
        webView.load(URLRequest(url: url))
    }
    
    override var prefersStatusBarHidden: Bool {
        return !UserDefaults.standard.bool(forKey: "edomi_show_titlebar")
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    @objc func defaultsChanged() {
        loadUrl()
        self.setNeedsStatusBarAppearanceUpdate();
    }
}
