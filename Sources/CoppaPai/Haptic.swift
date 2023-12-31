//
//  Haptic.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 12/13/23.
//

import SwiftUI

@available(iOS 13.0, *)
public func softHaptic() {
    let impactMed = UIImpactFeedbackGenerator(style: .soft)
    impactMed.impactOccurred()
}

@available(iOS 13.0, *)
public func heavyHaptic() {
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
    impactMed.impactOccurred()
}
