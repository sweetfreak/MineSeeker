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
    var isLandscape: Bool = UIDevice.current.orientation.isLandscape
//    var previousOrientation: UIDeviceOrientation = .portrait
}

struct OrientationReaderView: View {
    var onChange: (Bool) -> Void
    
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
        let isLandscape = proxy.size.width > proxy.size.height
        onChange(isLandscape)
    }
}

//struct OrientationReaderView: View {
//    var onChange: (Bool) -> Void
//    
//    var body: some View {
//        GeometryReader { geometry in
//            let isLandscape = geometry.size.width > geometry.size.height
//            Color.clear
//                .preference(key: OrientationPreferenceKey.self, value: isLandscape)
//        }
//        .frame(width: 0, height: 0) // occupies no space
//        .onPreferenceChange(OrientationPreferenceKey.self) { value in
//            onChange(value)
//        }
//        .allowsHitTesting(false) // ignores taps
//    }
//}

//struct OrientationPreferenceKey: PreferenceKey {
//    static var defaultValue: Bool = false
//    static func reduce(value: inout Bool, nextValue: () -> Bool) {
//        value = nextValue()
//    }
//}


//struct OrientationReader<Content: View>: View {
//    @StateObject private var orientation = OrientationModel()
//    let content: (Bool) -> Content
//    
//    var body: some View {
//        GeometryReader { geo in
//            let landscape = geo.size.width > geo.size.height
//            Color.clear
//                .onAppear { orientation.isLandscape = landscape }
//                .onChange(of: geo.size) {_, newSize in
//                    orientation.isLandscape = newSize.width > newSize.height
//                }
//            content(orientation.isLandscape)
//        }
//    }
//}
