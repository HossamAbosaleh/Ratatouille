//
//  ImagesModel.swift
//  Ratatouille
//
//  Created by Abo Saleh on 12/01/2023.
//

import Foundation

struct Images : Codable {
    let tHUMBNAIL : THUMBNAIL?
    let sMALL : SMALL?
    let rEGULAR : REGULAR?
    let lARGE : LARGE?

    enum CodingKeys: String, CodingKey {

        case tHUMBNAIL = "THUMBNAIL"
        case sMALL = "SMALL"
        case rEGULAR = "REGULAR"
        case lARGE = "LARGE"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tHUMBNAIL = try values.decodeIfPresent(THUMBNAIL.self, forKey: .tHUMBNAIL)
        sMALL = try values.decodeIfPresent(SMALL.self, forKey: .sMALL)
        rEGULAR = try values.decodeIfPresent(REGULAR.self, forKey: .rEGULAR)
        lARGE = try values.decodeIfPresent(LARGE.self, forKey: .lARGE)
    }

}

struct REGULAR : Codable {
    let url : String?
    let width : Int?
    let height : Int?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case width = "width"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }

}

struct SMALL : Codable {
    let url : String?
    let width : Int?
    let height : Int?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case width = "width"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }

}

struct THUMBNAIL : Codable {
    let url : String?
    let width : Int?
    let height : Int?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case width = "width"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }

}

struct LARGE : Codable {
    let url : String?
    let width : Int?
    let height : Int?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case width = "width"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }

}
