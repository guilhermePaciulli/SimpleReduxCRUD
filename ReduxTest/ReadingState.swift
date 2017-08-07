//
//  ReadingState.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 04/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import ReSwift

struct ReadingState: StateType {
    
    var beers: [Beer]
    
    init() {
        beers = Beer.fetchAll()
    }
    
}
