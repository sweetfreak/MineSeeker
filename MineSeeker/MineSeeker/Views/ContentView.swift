//
//  ContentView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 8/21/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                
                
                FieldView()
                    .padding()
            }
            .navigationTitle("MineSeeker")
        }
        
    }
}

#Preview {
    ContentView()
}
