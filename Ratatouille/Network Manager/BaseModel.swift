//
//  BaseModel.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation

struct BaseModel<T: Decodable> : Decodable {
    
    let from : Int?
    let to : Int?
    let count : Int?
    let _links : Next?
    let data : T?

    enum CodingKeys: String, CodingKey {

        case from = "from"
        case to = "to"
        case count = "count"
        case _links = "_links"
        case data = "hits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        _links = try values.decodeIfPresent(Next.self, forKey: ._links)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
    
}

struct Next : Codable {
    let next : Link_Next?
    
    enum CodingKeys: String, CodingKey {
        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        next = try values.decodeIfPresent(Link_Next.self, forKey: .next)
    }

}

struct Link_Next : Codable {
    let href : String?
    let title : String?

    enum CodingKeys: String, CodingKey {

        case href = "href"
        case title = "title"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        href = try values.decodeIfPresent(String.self, forKey: .href)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

}
