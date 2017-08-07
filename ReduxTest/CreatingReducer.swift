//
//  CreatingReducer.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 07/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import ReSwift

func CreatingReducer(action: Action, state: CreatingState?) -> CreatingState {
    
    var state = state ?? CreatingState(errors: [])
    
    switch action {
    case let creatingAction as CreateAction:
        state.errors = Beer.insertBeer(with: creatingAction.name, and: creatingAction.price, and: creatingAction.picture)
    default:
        break
    }
    
    return state
    
}
