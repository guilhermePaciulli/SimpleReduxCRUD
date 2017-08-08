//
//  InspectReducer.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 08/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import ReSwift
import UIKit

func inspectReducer(action: Action, state: InspectState?) -> InspectState {
    
    var state = state ?? InspectState(name: "", price: 0.0, picture: UIImage())
    
    switch action {
    case let inspectAction as InspectAction:
        let beer = inspectAction.beer
        if let beerName = beer.name {
            state.name = beerName
        }
        state.price = beer.price
        state.picture = beer.getPicture()
    default:
        break
    }
    
    return state
}
