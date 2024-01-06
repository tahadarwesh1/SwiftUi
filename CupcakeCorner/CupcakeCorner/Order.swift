//
//  Order.swift
//  CupcakeCorner
//
//  Created by Taha Darwish on 05/01/2024.
//

import Foundation

@Observable
class Order : Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress : Bool {
        let validName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let validStreetAddress = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let validCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let validZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        if validName.isEmpty || validStreetAddress.isEmpty || validCity.isEmpty || validZip.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    var userAddress : UserAddress {
        get {
            UserAddress(name: name, streetAddress: streetAddress, city: city, zip: zip)
        }
        set {
            name = newValue.name
            streetAddress = newValue.streetAddress
            city = newValue.city
            zip = newValue.zip
            saveAddress()
        }
    }
    
    func saveAddress() {
        if let encodedData = try? JSONEncoder().encode(userAddress) {
            UserDefaults.standard.set(encodedData, forKey: "UserAddress")
        }
    }
    
    func loadAddress() {
        let savedAddress = UserDefaults.standard.data(forKey: "UserAddress")
        if let decodedData = try? JSONDecoder().decode(UserAddress.self, from: savedAddress ?? Data()) {
         userAddress = decodedData
        }
    }
    
    init(){
        loadAddress()
    }
    
    var cost : Decimal {
        //2$ per cake
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        //$1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        //$0.5/cake for added sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
    }
}

struct UserAddress : Codable {
    var name : String
    var streetAddress : String
    var city : String
    var zip : String
    
}
