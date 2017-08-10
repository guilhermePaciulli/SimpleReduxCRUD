//
//  UpdateAction.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 10/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation
import ReSwift
import UIKit

struct UpdateAction: Action {
    
    var beer: Beer
    var name: String
    var price: Float
    var picture: UIImage
    
}
