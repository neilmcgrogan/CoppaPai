/*
 Misc functions
 */


import SwiftUI

public struct CoppaPai {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
extension View {
    
    public func startUpSettings() -> some View {
        self
            .buttonStyle(PlainButtonStyle())
            .dynamicTypeSize(.medium)
    }
}
