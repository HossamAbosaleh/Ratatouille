//
//  HitsModel.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation

struct HitsModel : Codable {
    let recipe : Recipe?
    let _links : _linksModel?

    enum CodingKeys: String, CodingKey {

        case recipe = "recipe"
        case _links = "_links"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recipe = try values.decodeIfPresent(Recipe.self, forKey: .recipe)
        _links = try values.decodeIfPresent(_linksModel.self, forKey: ._links)
    }

}





