//
//  EndPoints.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation


class Endpoints: NSObject {
            
    // MARK: - Api url
     static let BASE_API_URL = "https://api.edamam.com/api/recipes/v2"
    
    // MARK: - Auth
    static var login:String {return BASE_API_URL + "login"}
}
