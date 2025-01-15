//
//  PomodoroPoint.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 04/01/25.
//

import Foundation

struct PomodoroPoint: Identifiable {
    let id = UUID()
    var day: Date
    var ciclos: Int
}
