//
//  OrientationReader.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/15/25.
//

import SwiftUI
import Combine

//struct OrientationReader<Content: View>: View {
//    
//    @ViewBuilder var content: (Bool) -> Content
//    
//    var body: some View {
//        GeometryReader { geo in
//            let isLandscape = geo.size.width > geo.size.height
//            content(isLandscape)
//        }
//    }
//}

@Observable
final class OrientationModel: ObservableObject {
    var current: UIDeviceOrientation = UIDevice.current.orientation
    var previous: UIDeviceOrientation = .portrait
    
    var isLandscape: Bool {
        current.isLandscape
    }
}

struct OrientationReaderView: View {
    var onChange: (UIDeviceOrientation) -> Void
    
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .contentShape(Rectangle()) // only needed if hit testing, here optional
                .onAppear {
                    reportOrientation(proxy: proxy)
                }
                .onChange(of: proxy.size) {
                    reportOrientation(proxy: proxy)
                }
        }
        .allowsHitTesting(false) // makes it completely non-interactive
    }
    
    private func reportOrientation(proxy: GeometryProxy) {
        let orientation: UIDeviceOrientation
        if proxy.size.width > proxy.size.height {
            orientation = UIDevice.current.orientation.isLandscape ? UIDevice.current.orientation : .landscapeLeft
        } else {
            orientation = .portrait
        }
        onChange(orientation)
    }
}
