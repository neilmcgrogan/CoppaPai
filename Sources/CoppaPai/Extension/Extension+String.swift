//
//  Extension+String.swift
//  Lapala
//
//  Created by Neil McGrogan on 10/3/23.
//

import SwiftUI

extension String {
    subscript(_ index: Int) -> String? {
        guard index >= 0, index < self.count else {
            return nil
        }

        return String(self[self.index(self.startIndex, offsetBy: index)])
    }
}
