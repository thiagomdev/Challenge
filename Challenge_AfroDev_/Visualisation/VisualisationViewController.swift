//
//  ViewController.swift
//  Challenge_AfroDev_
//
//  Created by Thiago Monteiro on 11/25/20.
//

import UIKit

final class VisualisationViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var products: ProductABinBev?
   
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Label and Image Animation
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.labelName.transform = .init(scaleX: 1.25, y: 1.25)
        }) { [self] (finished: Bool) -> Void in
            self.labelName.text = products?.produto
            UIView.animate(withDuration: 0.50, animations: { () -> Void in
                self.labelName.transform = .identity
                self.labelName.textColor = .darkGray
            })
        }
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.imageView.transform = .init(scaleX: 1.25, y: 1.25)
        }) { [self] (finished: Bool) -> Void in
            imageView.load(url: URL(string: products!.imagem!)!)
            UIView.animate(withDuration: 0.50, animations: { () -> Void in
                self.imageView.transform = .identity
            })
        }
        
        if let items = products {
            labelName.text = items.produto
            imageView.load(url: URL(string: items.imagem!)!)
        }
    }
}



