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
    @Published var contarTempo: ContarTempo!

    init() {
        let timer = TimerManager(initialTime:100)
        self.timer = timer
        self.contarTempo = ContarTempo(timerViewModel: self)
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
        contarTempo.contarCiclos()
    }

    func resetarTimer() {
        timer.resetTimer()
    }
}


