//
//  ReadingReducer.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 04/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import ReSwift

func readingReducer(action: Action, state: ReadingState?) -> ReadingState {
    
    var state = state ?? ReadingState()
    
    switch action {
    case let fetchByNameAction as FetchByNameAction:
        state.beers = Beer.fetch(by: fetchByNameAction.name)
    case let deleteAction as DeleteAction:
        let beerToBeDeleted = deleteAction.beer
        DatabaseController.persistentContainer.viewContext.delete(beerToBeDeleted)
        DatabaseController.saveContext()
        state = ReadingState()
    default:
        break
    }
    
    
    return state
    
}
