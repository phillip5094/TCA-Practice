//
//  WebView.swift
//  TCA-Practice
//
//  Created by Philip Chung on 2023/07/20
//

import SwiftUI
import ComposableArchitecture

struct WebView: UIViewControllerRepresentable {
    private let url: URL
    /*
     단순히, 웹뷰만 띄우고 싶을 경우엔 Store를 넘길 필요가 없기 때문에 optional로 설정.
     */
    private let store: StoreOf<WebViewReducer>?
    
    init(url: URL, store: StoreOf<WebViewReducer>? = nil) {
        self.url = url
        self.store = store
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let webViewController = WebViewController(url: url, store: store)
        return webViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
