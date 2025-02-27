//
//  raiodeSolmodel.swift
//  SolEquipe38
//
//  Created by Daniel Araujo Nobre on 06/02/25.
//


import Foundation

struct SolarRayModel: Identifiable  {
    var id: UUID = UUID()
    var initialSpacing: CGFloat = 0
    var subdivision: Int
}
