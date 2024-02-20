//
//  BuildingSearchButton.swift
//  CampusMap
//
//  Created by Roy Schor on 2/19/24.
//

import SwiftUI

struct BuildingSearchButton: View {
    @EnvironmentObject var manager : MapManager
    @State private var showBuildingList = false
    
    var body: some View {
        
        Button(action: {
            showBuildingList.toggle()
        }) {
            Image(systemName: "building.2.crop.circle")
                .font(.system(size: 30))
                .foregroundColor(.primary)
        }
        .sheet(isPresented: $showBuildingList) {
            BuildingListView()
                .environmentObject(manager)
        }
    }
}

#Preview {
    BuildingSearchButton()
        .environmentObject(MapManager())
}
