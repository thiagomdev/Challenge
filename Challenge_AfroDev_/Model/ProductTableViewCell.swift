//
//  ProductTableViewCell.swift
//  Challenge_AfroDev_
//
//  Created by Thiago Monteiro on 11/25/20.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    // MARK: - Properties
    var product: ProductABinBev?
    
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Methods
    func setUp(with product: ProductABinBev) {
        labelTitle.text = product.produto
        
        labelSubtitle.text = product.descricao
        labelPrice.text = String("\(product.preco)")
        
        labelPrice.textColor = product.desconto! ? UIColor.green : UIColor.black
        
        if let price =  product.preco {
            labelPrice.text = "R$ \(price)"
        }
        
        if let image =  product.imagem {
            productImage.load(url: URL(string: image)!)
        }
       
    }

}

