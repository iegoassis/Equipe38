//
//  raiodesolviewmodel.swift
//  SolEquipe38
//
//  Created by Daniel Araujo Nobre on 06/02/25.
//

import SwiftUI

class SolarRayViewModel: ObservableObject {
    
    @Published var rays: [SolarRayModel] = []

    init(subdivisions: Int) {
        self.rays = []
        
        for i in 0..<subdivisions {
            let solarRayModel = SolarRayModel(subdivision: i)
            self.rays.append(solarRayModel)
        }
    }
    
}

extension Date {
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

