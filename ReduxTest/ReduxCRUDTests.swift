//
//  ReduxCRUDTests.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 10/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import XCTest
import CoreData
import ReSwift
@testable import ReduxTest

class ReduxCRUDTests: XCTestCase {
    
    var store = Store<AppState>(reducer: appReducer, state: nil)
    
    override func setUp() {
        _ = Beer.fetchAll().map({ DatabaseController.persistentContainer.viewContext.delete($0) })
        store = Store<AppState>(reducer: appReducer, state: nil)
    }
    
    func testCreateAction() {
        
        let name = "Guinness"
        let price = Float(exactly: 13.0)
        let picture = UIImage(named: "Guinness.jpg")
        
        let createAction = CreateAction(name: name, price: price!, picture: picture!)
        
        store.dispatch(createAction)
                
        let fetchAllAction = FetchAllAction()
        
        store.dispatch(fetchAllAction)
        
        XCTAssert(store.state.readingState.beers.count == 1)
        
    }
    
    func testSearchAction() {
        
        let store = Store<AppState>(reducer: appReducer, state: nil)
        
        let name = "Guinness"
        let price = Float(exactly: 13.0)
        let picture = UIImage(named: "Guinness.jpg")
        
        let createAction = CreateAction(name: name, price: price!, picture: picture!)
        
        store.dispatch(createAction)
        
        let fetchByName = FetchByNameAction(name: "Gui")
        
        store.dispatch(fetchByName)
        
        XCTAssert(store.state.readingState.beers.count == 1)
    }
    
}
