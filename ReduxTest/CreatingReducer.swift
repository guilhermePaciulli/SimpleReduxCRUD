//
//  CreatingReducer.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 07/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import ReSwift

func creatingReducer(action: Action, state: CreatingState?) -> CreatingState {
    
    let state = state ?? CreatingState()
    
    switch action {
    case let creatingAction as CreateAction:
        Beer.insertBeer(with: creatingAction.name, and: creatingAction.price, and: creatingAction.picture)
    default:
        break
    }
    
    return state
    
}
