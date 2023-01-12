//
//  RecipeModel.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation

struct Recipe : Codable {
    let label : String?
    let image : String?
    let images : Images?
    let source : String?
    let url : String?
    let shareAs : String?
    let totalWeight : Double?
    let totalTime : Int?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case image = "image"
        case images = "images"
        case source = "source"
        case url = "url"
        case shareAs = "shareAs"
        case totalWeight = "totalWeight"
        case totalTime = "totalTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        images = try values.decodeIfPresent(Images.self, forKey: .images)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        shareAs = try values.decodeIfPresent(String.self, forKey: .shareAs)
        totalWeight = try values.decodeIfPresent(Double.self, forKey: .totalWeight)
        totalTime = try values.decodeIfPresent(Int.self, forKey: .totalTime)
    }

}
