//
//  contarTempo.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 08/03/25.
//
import SwiftUI

class TimerViewModel: ObservableObject {
    enum TimeTypes {
        case atividade, descanso
    }

    @Published var estadoTimer: TimeTypes = .atividade
    @Published var tempoAtividade: Double = 100
    @Published var tempoDescanso: Double = 10
    @Published var timer: TimerManager

    init() {
        self.timer = TimerManager(initialTime: 100)
    }

    func mudarEstadoTimer() {
        switch estadoTimer {
        case .atividade:
            estadoTimer = .descanso
            timer.stopTimer()
            timer = TimerManager(initialTime: tempoDescanso)
        case .descanso:
            estadoTimer = .atividade
            timer.stopTimer()
            timer = TimerManager(initialTime: tempoAtividade)
        }
    }

    func resetarTimer() {
        timer.resetTimer()
    }
}
