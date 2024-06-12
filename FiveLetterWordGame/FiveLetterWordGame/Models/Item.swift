//
//  Item.swift
//  FiveLetterWordGame
//
//  Created by Sean Connolly on 6/6/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
