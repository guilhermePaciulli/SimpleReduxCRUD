//
//  ReduxCRUDTests.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 10/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import XCTest
import CoreData
@testable import ReduxTest
import ReSwift

class ReduxCRUDTests: XCTestCase {
    
    let managedObject = setUpInMemoryManagedObjectContext()
    
    func testCreateActionSuccess() {
        
        let store = Store<AppState>(reducer: appReducer, state: nil)
        
        let name = "Guinness"
        let price = Float(exactly: 13.0)
        let picture = UIImage(named: "Guinness.jpg")
        
        let createAction = CreateAction(name: name, price: price!, picture: picture!)
        
        store.dispatch(createAction)
        
        XCTAssert(store.state.creatingState.errors.isEmpty)
        
        
    }
    
}

func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
    
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    
    do {
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    } catch {
        print("Adding in-memory persistent store failed")
    }
    
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    
    return managedObjectContext
}
