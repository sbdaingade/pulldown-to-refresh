//
//  ViewModifiers.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import Foundation
import SwiftUI

extension View {
 @ViewBuilder
    func addRefreshableView(action: @escaping () -> Void) -> some View {
        if #available(iOS 15.0, *) {
//            self.refreshable {
//                action()
//            }
        } else {
            self.modifier(customRefreshView(action: action))
        }
    }
}

struct customRefreshView: ViewModifier {
    let action: () -> Void
    func body(content: Content) -> some View {
        ZStack {
            GeometryReader { geometryReader in
                RefreshableScrollView(width: geometryReader.size.width, height: geometryReader.size.height) {
                    action()
                } rootView: {
                    content
                }
            }
        }
    }
}
