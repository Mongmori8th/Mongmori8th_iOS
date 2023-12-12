//
//  Message.swift
//  Mongmori
//
//  Created by 지정훈 on 12/12/23.
//

import Foundation

struct Message: Hashable{
    var id = UUID()
    var sender: String?
    var content: String
    var image: String?
    var button: Bool?
}
