//
//  ListItem.swift
//  FetchApp
//
//  Created by Sathish Kumar G on 10/9/20.
//  Copyright © 2020 Sathish Kumar G. All rights reserved.
//

import Foundation

typealias List = [ListItem]

struct ListItem: Decodable {
    let id: Int
    let listID: Int
    let name: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        listID = try container.decode(Int.self, forKey: .listID)
        name = try container.decode(String?.self, forKey: .name)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case listID = "listId"
        case name
    }
}


struct Objects {
    var sectionName : Int
    var sectionObjects : [ListItem]
}
