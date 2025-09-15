//
//  OptionsView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/11/25.
//

import SwiftUI

struct OptionsView: View {
    
    @AppStorage("sfx") var sfxSave = true
    @AppStorage("music") var musicSave = true
    
    var vm: FieldViewModel
    
    var body: some View {
        Spacer()
        Spacer()
        Button {
            vm.sfx.toggle()
            UserDefaults.standard.set(vm.sfx, forKey: "sfx")
            if vm.sfx {
                vm.playSFX("buttonUp1")
            }
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
            if vm.sfx {
                vm.playSFX("buttonUp1")
            } else {
                vm.playSFX("buttondown1")
            }
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
