//
//  FieldNode.swift
//  TrufflePig
//
//  Created by Satindar Dhillon on 4/27/15.
//  Copyright (c) 2015 Jaya. All rights reserved.
//

import Foundation

struct FieldNode {
    var pigHasDugHere: Bool = false
    var itemValue: Int
    
    init(itemValue value: Int) {
        itemValue = value
    }
}