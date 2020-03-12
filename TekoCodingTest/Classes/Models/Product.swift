//
//  Product.swift
//  TekoCodingTest
//
//  Created by Hao Dam on 3/11/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    var sku: String?
    var name: String?
    var url: String?
    var price: Price?
    var promotionPrices: [PromotionPrices]?
    var images: [Image]?
    var status: Status?
    var attributeGroups: [AttributeGroups]?
    
    init() {
        
    }
    
    init(_ json: JSON) {
        sku = json["sku"].stringValue
        name = json["name"].stringValue
        url = json["url"].stringValue
        images = json["images"].arrayValue.map({ Image($0) })
        price = Price(json["price"])
        promotionPrices = json["promotionPrices"].arrayValue.map({ PromotionPrices($0) })
        status = Status(json["status"])
        attributeGroups = json["attributeGroups"].arrayValue.map({ AttributeGroups($0) })
    }
}

struct Seller {
    var id: Int?
    var name: String?
    var displayName: String?
    
    init(id: Int?, name: String?, displayName: String?) {
        self.id = id
        self.name = name
        self.displayName = displayName
    }
}

struct Price {
    var supplierSalePrice: Int?
    var sellPrice: Int?
    
    init(sellPrice: Int?, supplierSalePrice: Int?) {
        self.sellPrice = sellPrice
        self.supplierSalePrice = supplierSalePrice
    }
    
    init(_ json: JSON) {
        sellPrice = json["sellPrice"].intValue
        supplierSalePrice = json["supplierSalePrice"].intValue
    }
}

struct PromotionPrices {
    var finalPrice: Int?
    var bestPrice: Int?
    
    init(finalPrice: Int?, bestPrice: Int?) {
        self.finalPrice = finalPrice
        self.bestPrice = bestPrice
    }
    
    init(_ json: JSON) {
        finalPrice = json["finalPrice"].intValue
        bestPrice = json["bestPrice"].intValue
    }
}

struct Status {
    var isPublish: Bool?
    var sale: String?
    
    init(isPublish: Bool?, sale: String?) {
        self.isPublish = isPublish
        self.sale = sale
    }
    
    init(_ json: JSON) {
        isPublish = json["publish"].boolValue
        sale = json["sale"].stringValue
    }
}

struct Image {
    var url: String?
    var priority: Int?
    var path: String?
    
    init() {
    }
    
    init(url: String?, priority: Int?, path: String?) {
        self.url = url
        self.priority = priority
        self.path = path
    }
    
    init(_ json: JSON) {
        url = json["url"].stringValue
        priority = json["priority"].intValue
        path = json["path"].stringValue
    }
}

struct AttributeGroups {
    var name: String?
    var value: String?
    
    init() {
    }
    
    init(name: String?, value: String?) {
        self.name = name
        self.value = value
    }
    
    init(_ json: JSON) {
        name = json["name"].stringValue
        value = json["value"].stringValue
    }
}

