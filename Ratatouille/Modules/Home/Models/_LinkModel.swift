//
//  _LinkModel.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation

struct _linksModel : Codable {
    let self_link : Self_linkModel?

    enum CodingKeys: String, CodingKey {

        case self_link = "self"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self_link = try values.decodeIfPresent(Self_linkModel.self, forKey: .self_link)
    }

}

//MARK: - Self_link Model
struct Self_linkModel : Codable {
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
