//
//  OptionsView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/11/25.
//

import SwiftUI

struct OptionsView: View {
    
    var vm: FieldViewModel
    
    var body: some View {
        Spacer()
        Spacer()
        Button {
            vm.sfx.toggle()
        } label: {
            Label(vm.sfx ? "Sound Effects On" : "Sound Effects Off", systemImage: "waveform.circle")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce)
                .padding(10)
                .foregroundColor(.primary)
                .background(vm.sfx ? .blue : .gray)
                .cornerRadius(20)
                //.
        }
        
        Button {
            vm.music.toggle()
        } label: {
            Label(vm.music ? "Music On" : "Music Off", systemImage: "music.quarternote.3")
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.bounce)
                .padding(10)
                .foregroundColor(.primary)
                .background(vm.music ? .blue : .gray)
                .cornerRadius(20)
                //.
        }
        Spacer()
        HomeButtonView(vm: vm)
        Spacer()
    }
}

#Preview {
    OptionsView(vm: FieldViewModel())
}
