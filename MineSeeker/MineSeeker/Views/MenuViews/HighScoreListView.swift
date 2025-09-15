//
//  HighScoreListView.swift
//  MineSeeker
//
//  Created by Jesse Sheehan on 9/6/25.
//

import SwiftUI
import SwiftData

struct HighScoreListView: View {
    
    
    
    @Environment(\.modelContext) private var modelContext
    @State var vm: FieldViewModel

    
    var body: some View {
        
        VStack {
            Text("HIGH SCORES")
                .font(Font.largeTitle.bold())
            
            Spacer()
            
            VStack {
                if UIDevice.isIPhone {
                    List {
                        Grid {
                            GridRow {
                                Text("Name")
                                //.gridCellAnchor(UnitPoint(x: 1, y: 0.5))
                                Spacer()
                                Text("Score")
                                Spacer()
                                Text("Size")
                                Spacer()
                                Text("Date")
                            }
                            .font(Font.title3.bold())
                            Divider()
                            if vm.hsvm.highScores.isEmpty {
                                Text("There are no high scores yet.")
                                    .font(Font.caption)
                                
                            } else {
                                ForEach(vm.hsvm.highScores.prefix(10)) { highScore in
                                    GridRow {
                                        Text(highScore.name)
                                        // .gridCellAnchor(UnitPoint(x: 1, y: 0.5))
                                        Spacer()
                                        Text(String(highScore.score))
                                        Spacer()
                                        Text(String(label(for: highScore.gridSize)))
                                        Spacer()
                                        Text(highScore.date.shortFormat)
                                        //.gridCellAnchor(UnitPoint(x: 0, y: 0.5))
                                        //.gridCellAnchor(UnitPoint(x: 0, y: 0.5))
                                    }
                                    .font(Font.caption)
                                    if highScore != vm.hsvm.highScores.last {
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                } else
                {
                    Table(vm.hsvm.highScores){
                        TableColumn("Name", value: \.name)
                        TableColumn("Date") { entry in
                            Text(entry.date, format: .dateTime.day().month().year())
                        }
                        TableColumn("GridSize") {entry in
                            Text(label(for: entry.gridSize))
                        }
                        TableColumn("Score") { entry in
                            Text(String(entry.score))
                        }
                    }
                

                }
            }
            HomeButtonView(vm: vm)
        }
        .onAppear {
            vm.hsvm.fetchHighScores(from: modelContext)
        }
    }
    
    private func label(for size: GridSize) -> String {
        switch size {
        case .small: return "Small"
        case .med: return "Medium"
        case .big: return "Big"
        case .huge: return "Huge"
        }
    }
}


#Preview {
    HighScoreListView(vm: FieldViewModel())
}
