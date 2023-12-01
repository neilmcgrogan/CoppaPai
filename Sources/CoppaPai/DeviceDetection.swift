//
//  DeviceDetection.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 11/27/23.
//

import SwiftUI

public let width = UIScreen.main.bounds.height > UIScreen.main.bounds.width ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
public let startedInLandscape = UIScreen.main.bounds.height > UIScreen.main.bounds.width ? false : true
// No longer in use
//public let screen = UIScreen.main.bounds

public func isIPad() -> Bool {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return true
    } else {
        return false
    }
}

@available(iOS 13.0, *)
public struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    public init(action: @escaping (UIDeviceOrientation) -> Void) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

@available(iOS 13.0, *)
// A View wrapper to make the modifier easier to use
extension View {
    public func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
