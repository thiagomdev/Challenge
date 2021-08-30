//
//  UIImageViewExtension.swift
//  Challenge_AfroDev_
//
//  Created by Thiago Monteiro on 11/26/20.
//


import UIKit
// MARK: - Extensions
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


