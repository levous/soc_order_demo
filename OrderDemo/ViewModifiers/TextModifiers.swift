//
//  TextModifiers.swift
//  OrderDemo
//
//  Created by Russell Zarse on 9/7/24.
//

import Foundation
import SwiftUI


extension Text {
    func captionText() -> Text {
        self
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}
