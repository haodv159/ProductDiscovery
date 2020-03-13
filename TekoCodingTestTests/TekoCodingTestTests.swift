//
//  TekoCodingTestTests.swift
//  TekoCodingTestTests
//
//  Created by Hao Dam on 3/9/20.
//  Copyright © 2020 Hao Dam. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import TekoCodingTest

extension Product {
    
    static func validJson() -> JSON {
        return [
            "sku": "1200013",
            "name": "Bộ định tuyến/ ADSL Draytek V2700E",
            "url": "b-d-nh-tuy-n-adsl-draytek-v2700e",
            "seller": [
                "id": 1,
                "name": "CÔNG TY CỔ PHẦN THƯƠNG MẠI DỊCH VỤ PHONG VŨ",
                "displayName": "Phong Vũ"
            ],
            "status": [
                "publish": false,
                "sale": "ngung_kinh_doanh"
            ],
            "objective": [
                "code": "sale",
                "name": "Hàng để bán"
            ],
            "images": [],
            "price": [
                "supplierSalePrice": 600000.0,
                "sellPrice": 800000.0
            ],
            "promotionPrices": [
                [
                    "channel": "pv_online",
                    "terminal": "CP01",
                    "finalPrice": 800000.0,
                    "promotionPrice": nil,
                    "bestPrice": 800000.0,
                    "flashSalePrice": nil
                ]
            ],
            "attributeGroups": [
                [
                    "id": 101,
                    "name": "Thương hiệu",
                    "value": "DRAYTEK",
                    "parentId": 102,
                    "priority": 0
                ],
                [
                    "id": 102,
                    "name": "Bảo hành",
                    "value": "12",
                    "parentId": 102,
                    "priority": 1
                ],
                [
                    "id": 103,
                    "name": "Cấu hình chi tiết",
                    "value": "",
                    "parentId": 0,
                    "priority": 1101
                ]
            ]
        ]
    }
        
    static func getProduct1200013() -> Product {
        let product = Product()
        product.sku = "1200013"
        product.name = "Bộ định tuyến/ ADSL Draytek V2700E"
        product.url = "b-d-nh-tuy-n-adsl-draytek-v2700e"
        product.price = Price(sellPrice: 800000.0, supplierSalePrice: 600000.0)
        product.promotionPrices = [PromotionPrices(finalPrice: 800000.0, bestPrice: 800000.0)]
        product.status = Status(isPublish: false, sale: "ngung_kinh_doanh")
        product.attributeGroups = [AttributeGroups(name: "Thương hiệu", value: "DRAYTEK"),
                                   AttributeGroups(name: "Bảo hành", value: "12"),
                                   AttributeGroups(name: "Cấu hình chi tiết", value: "")]
        return product
    }
}

class TekoCodingTestTests: XCTestCase {
    
    var product: Product!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        product = Product(Product.validJson())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        product = nil
        super.tearDown()
    }

    func testParseJSONNormal() {
        XCTAssertEqual(product.sku, Product.getProduct1200013().sku, "Parse JSON is wrong")
        XCTAssertEqual(product.name, Product.getProduct1200013().name, "Parse JSON is wrong")
        XCTAssertEqual(product.url, Product.getProduct1200013().url, "Parse JSON is wrong")
    }

    func testParseJSONForPrice() {
        XCTAssertEqual(product.price?.sellPrice, Product.getProduct1200013().price?.sellPrice, "Parse JSON for sellPrice is wrong")
        XCTAssertEqual(product.price?.supplierSalePrice, Product.getProduct1200013().price?.supplierSalePrice, "Parse JSON for supplierSalePrice is wrong")
    }

    func testParseJSONForPromotionPrice() {
        XCTAssertEqual(product.promotionPrices?.first?.finalPrice, Product.getProduct1200013().promotionPrices?.first?.finalPrice, "Parse JSON for finalPrice is wrong")
        XCTAssertEqual(product.promotionPrices?.first?.bestPrice, Product.getProduct1200013().promotionPrices?.first?.bestPrice, "Parse JSON for bestPrice is wrong")
    }

    func testParseJSONForStatus() {
        XCTAssertEqual(product.status?.isPublish, Product.getProduct1200013().status?.isPublish, "Parse JSON for isPublish is wrong")
        XCTAssertEqual(product.status?.sale, Product.getProduct1200013().status?.sale, "Parse JSON for sale is wrong")
    }

    func testParseJSONForAttributeGroups() {
        XCTAssertEqual(product.attributeGroups?.first?.name, Product.getProduct1200013().attributeGroups?.first?.name, "Parse JSON for name is wrong")
        XCTAssertEqual(product.attributeGroups?.first?.value, Product.getProduct1200013().attributeGroups?.first?.value, "Parse JSON for value is wrong")
    }

    func testDiscountNormal() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertEqual(product.discount, 25, "Normal: Discount is wrong")
    }

    func testDiscountAbnormal() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertNotEqual(product.discount, 0, "Abnormal: Discount is wrong")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
