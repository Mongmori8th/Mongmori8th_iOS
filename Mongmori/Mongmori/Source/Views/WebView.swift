//
//  WebView.swift
//  Mongmori
//
//  Created by 지정훈 on 12/12/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var urlString: String
    let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
    let nmap = URL(string: "nmap://actionPath?parameter=value&appname=appname=com.Mongmori.Mongmori")!
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            if UIApplication.shared.canOpenURL(parent.nmap) {
                if let url = navigationAction.request.url, url.scheme == "nmap" {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
            } else {
                UIApplication.shared.open(parent.appStoreURL)
                decisionHandler(.cancel)
                return
            }
        }
    }
}

