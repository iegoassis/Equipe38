//
//  TimerManager.swift
//  SolEquipe38
//
//  Created by Daniel Araujo Nobre on 06/02/25.
//

import SwiftUI
import Combine

@Observable
class TimerManager {
    var initialTime: TimeInterval
    var timeRemaining: TimeInterval
    var timer: Timer?
    var isPaused: Bool = true
    var ciclos: Int = 0
    var cicloDiario: [PomodoroPoint] = []

    var cicloFinalizou: Int = 0  // Agora pode ser observado
    var TimerViewModel: TimerViewModel
    var formatedTime: String {
        let time = Int(timeRemaining)
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    init(initialTime: TimeInterval,timerViewModel: TimerViewModel) {
        self.initialTime = initialTime
        self.timeRemaining = initialTime
        self.TimerViewModel = timerViewModel
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            if !(self?.isPaused ?? false) {
                self?.tick()
                print(self?.timeRemaining ?? -1)
            }
        }
    }

    private func tick() {
        if timeRemaining > 0 {
            withAnimation {
                timeRemaining -= 0.1
            }
        } else {
            pauseUnpause()
        }
    }

    func appendTime(additionalTime: TimeInterval) {
        timeRemaining += additionalTime
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        cicloFinalizou += 1 // Notifica a UI
        timeRemaining = initialTime
    }
    
    func pauseUnpause() {
        isPaused.toggle()
        if !isPaused {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    func novoCiclo() {
        TimerViewModel.mudarEstadoTimer()
        if TimerViewModel.estadoTimer == .descanso{
            cicloFinalizou += 1
            ciclos += 1
        }
        let indexAtual = Calendar.current.component(.day, from: Date()) % 7
        if indexAtual < cicloDiario.count {
            cicloDiario[indexAtual].ciclos += 1
        }
        
        resetTimer()
    }
}

#Preview {
    TabBar()
}
