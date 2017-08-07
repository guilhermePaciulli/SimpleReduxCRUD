//
//  Extensions.swift
//  ReduxTest
//
//  Created by Guilherme Paciulli on 07/08/17.
//  Copyright © 2017 Guilherme Paciulli. All rights reserved.
//

import Foundation


extension String {
    public func isValid() -> Bool {
        return !(self.isEmpty || self.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}
