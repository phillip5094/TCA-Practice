//
//  WebViewController.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/20
//

import Foundation
import WebKit
import ComposableArchitecture

class WebViewController: UIViewController {
    private let url: URL
    private let store: StoreOf<WebViewReducer>?
    private let webView: WKWebView
    
    init(url: URL, store: StoreOf<WebViewReducer>?) {
        self.url = url
        self.webView = WKWebView(frame: .zero)
        self.store = store
        super.init(nibName: nil, bundle: nil)
        store?.send(.setWebViewController(self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        self.webView.frame = self.view.frame
        self.webView.load(URLRequest(url: url))
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
    }
    
    deinit {
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.url))
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        self.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
    }
    
    func refresh() {
        guard let targetURL = self.webView.url else {
            return
        }
        self.webView.evaluateJavaScript("document.body.remove()")
        self.webView.load(URLRequest(url: targetURL))
    }
    
    func goBack() {
        self.webView.goBack()
    }
    
    func goForward() {
        self.webView.goForward()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            guard let url = self.webView.url else {
                return
            }
            self.store?.send(.urlChanged(url))
        } else if keyPath == #keyPath(WKWebView.title) {
            guard let title = self.webView.title else {
                return
            }
            self.store?.send(.titleChanged(title))
        } else if keyPath == #keyPath(WKWebView.canGoBack) {
            self.store?.send(.canGoBack(self.webView.canGoBack))
        } else if keyPath == #keyPath(WKWebView.canGoForward) {
            self.store?.send(.canGoForward(self.webView.canGoForward))
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        store?.send(.decidePolicyForNavigationAction)
        return .allow
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        store?.send(.decidePolicyForNavigationResponse)
        return .allow
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        store?.send(.didFinishNavigation)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        store?.send(.didFailNaviation)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        store?.send(.didFailProvisionalNavigation)
    }
}
