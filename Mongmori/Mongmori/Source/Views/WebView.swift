//
//  WebView.swift
//  Mongmori
//
//  Created by 지정훈 on 11/30/23.
//
import SwiftUI
import WebKit

//제주도

struct WebView: View {
    @State private var webViewResult: String?

    var body: some View {
        VStack {
            MyWebView(urlToLoad: "http://13.209.49.103:8000/") { result in
                webViewResult = result
            }
            .edgesIgnoringSafeArea(.all)

            Text("Result: \(webViewResult ?? "No result")")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MyWebView: UIViewRepresentable {
    var urlToLoad: String
    var onResult: (String) -> Void

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlToLoad) else { return }
        uiView.load(URLRequest(url: url))
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MyWebView

        init(parent: MyWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.innerText") { result, error in
                if let resultString = result as? String {
                    self.parent.onResult(resultString)
                }
            }
        }
    }
}
