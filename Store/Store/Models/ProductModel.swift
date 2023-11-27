//
//  ProductModel.swift
//  Store
//
//  Created by Baramidze on 25.11.23.
//

import Foundation

// Decodable
struct ProductModel: Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
   
    //Int not Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    var selectedAmount: Int?
}

