//
//  DeviceDetection.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 11/27/23.
//

import SwiftUI

public func isIPad() -> Bool {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return true
    } else {
        return false
    }
}
