//
//  contTempo.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 08/03/25.
//
import SwiftUI

class ContarTempo: ObservableObject {
    var timerViewModel: TimerViewModel
    var cicloDescanso: Int = 0
    var cicloFoco: Int = 0
    init(timerViewModel: TimerViewModel) {
        self.timerViewModel = timerViewModel
    }

    func contarCiclos() {
        if timerViewModel.estadoTimer == .descanso {
            cicloDescanso += 1
            print("Ciclo de descanso completo!")
        } else {
            cicloFoco += 1
            print("Ciclo de atividade completo!")
        }
    }
}
