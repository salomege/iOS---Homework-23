//
//  ProductsListViewModel.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import Foundation



protocol ProductsListViewModelDelegate: AnyObject {
    func productsFetched()
    func productsAmountChanged()
    //add
    func showError(_ error: Error)
}


class ProductsListViewModel {
    
    weak var delegate: ProductsListViewModelDelegate?
    
    var products: [ProductModel]?
    var totalPrice: Double? { products?.reduce(0) { $0 + Double($1.price) * Double(($1.selectedAmount ?? 0))} }
    
    func viewDidLoad() {
        fetchProducts()
    }
    
    private func fetchProducts() {
        NetworkManager.shared.fetchProducts { [weak self] response in
            switch response {
            case .success(let products):
                self?.products = products
                self?.delegate?.productsFetched()
            case .failure(let error):
                self?.delegate?.showError(error)
                //TODO: handle Error
            }
        }
    }
    
    func addProduct(at index: Int) {
        guard var product = products?[index] else { return}
        //TODO: handle if products are out of stock
        if product.stock > 0 {
            product.selectedAmount = (products?[index].selectedAmount ?? 0 ) + 1
            delegate?.productsAmountChanged()
        } else {
            delegate?.showError(ProductError.productNotFound)
        }
        
    }
    
    func removeProduct(at index: Int) {
        guard var product = products?[index] else { return }
        //TODO: handle if selected quantity of product is already 0
        if  product.selectedAmount! > 0  {
            product.selectedAmount =
            (products?[index].selectedAmount ?? 0 ) - 1
            delegate?.productsAmountChanged()
            
            delegate?.productsAmountChanged()
        } else {
            delegate?.showError(ProductError.productNotFound)
        }
    }
    
    enum ProductError: Error {
        case productNotFound
        case outOfStock
        case invalidQuantity
    }
}
