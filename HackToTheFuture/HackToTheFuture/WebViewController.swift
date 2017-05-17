//
//  WebViewController.swift
//  HackToTheFuture
//
//  Created by Dominic Frazer Imregh on 17/05/2017.
//  Copyright © 2017 HackToTheFuture. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView?

    var info : InfoObject = InfoObject()

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlRequest = URLRequest.init(url: URL.init(string: info.url)!)
        self.webView.loadRequest(urlRequest)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activityView?.isHidden = false
        
        let urlRequest = URLRequest.init(url: URL.init(string: info.url)!)
        self.webView.loadRequest(urlRequest)
    }
}

extension WebViewController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityView?.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityView?.isHidden = true
        self.webView.loadHTMLString(info.title, baseURL: nil)
        
        self.showMessage(error.localizedDescription) { }
    }
}
