//
//  ChallengeAfroDevTableViewController.swift
//  Challenge_AfroDev_
//
//  Created by Thiago Monteiro on 11/25/20.
//

import UIKit

final class ChallengeAfroDevTableViewController: UITableViewController {

    // MARK: - Properties
    var product: [ProductABinBev] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
       loadProduct()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Methods
    private func loadProduct() {
        
        ProductAPI().loadProduct { (result) in
            switch result {
            case .success(let product):
                self.product = product
                print(product.count)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            case .failure(let productApiError):
                switch productApiError {
                case .badUrl:
                    print("URL inválida.")
                case .invalidStatusCode(let statusCode):
                    print("\(statusCode)")
                default:
                    print("Erro não encontrado!")
                }
            }
        }
           
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieVisualizationViewController = segue.destination as? VisualisationViewController,
           let row = tableView.indexPathForSelectedRow?.row {
            
            let picProduct = product[row]
            movieVisualizationViewController.products = picProduct
        }
    }
  
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return product.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        cell.setUp(with: product[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            if editingStyle == .delete {
                product.remove(at: indexPath.row)
                tableView.reloadData()
        }
    }
}
