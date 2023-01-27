//
//  ActivityIndicator.swift
//  empowermentLabs
//
//  Created by Daniel Crespo Duarte on 24/01/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    @Binding var isAnimating: Bool

    let style: UIActivityIndicatorView.Style
    
    init(isAnimating: Binding<Bool> = .constant(true), style: UIActivityIndicatorView.Style = .medium) {
        _isAnimating = isAnimating
        self.style = style
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
