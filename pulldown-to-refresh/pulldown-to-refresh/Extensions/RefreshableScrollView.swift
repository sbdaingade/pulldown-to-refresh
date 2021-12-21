//
//  RefreshableScrollView.swift
//  pulldown-to-refresh
//
//  Created by Sachin Daingade on 21/12/21.
//

import UIKit
import SwiftUI

struct RefreshableScrollView<RootView>: UIViewRepresentable where RootView: View {
    
    var width : CGFloat, height : CGFloat
    let handlePullToRefresh: () -> Void
    let rootView: () -> RootView
    
    func makeCoordinator() -> Coordinator<RootView> {
        Coordinator(self, rootView: rootView, handlePullToRefresh: handlePullToRefresh)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.addTarget(context.coordinator, action:
            #selector(Coordinator.handleRefreshControl),
                                          for: .valueChanged)

        let childView = UIHostingController(rootView: rootView() )
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        control.addSubview(childView.view)
        return control
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}

    class Coordinator<RootView>: NSObject where RootView: View {
        var control: RefreshableScrollView
        var handlePullToRefresh: () -> Void
        var rootView: () -> RootView

        init(_ control: RefreshableScrollView, rootView: @escaping () -> RootView, handlePullToRefresh: @escaping () -> Void) {
            self.control = control
            self.handlePullToRefresh = handlePullToRefresh
            self.rootView = rootView
        }

        @objc func handleRefreshControl(sender: UIRefreshControl) {

            sender.endRefreshing()
            handlePullToRefresh()
           
        }
    }
}
