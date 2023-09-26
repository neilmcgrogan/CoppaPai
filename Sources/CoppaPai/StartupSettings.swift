//
//  StartupSettings.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 9/25/23.
//

import SwiftUI

@available(macOS 12.0, *)
@available(iOS 15.0, *)
extension View {
    
    public func startUpSettings() -> some View {
        self
            .dynamicTypeSize(.medium)
            .preferredColorScheme(.light)
    }

}
