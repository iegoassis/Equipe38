//
//  TimerManager.swift
//  SolEquipe38
//
//  Created by Daniel Araujo Nobre on 06/02/25.
//

import SwiftUI

@Observable
class TimerManager {
    var initialTime: TimeInterval
    var timeRemaining: TimeInterval
    var timer: Timer?
    var isPaused: Bool = true
    var statusAtual: TimerStatus = .foco
    var formatedTime: String {
        let time = Int(timeRemaining)
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    enum TimerStatus{
        case descanso
        case foco
    }
    init(initialTime: TimeInterval) {
        self.initialTime = initialTime
        self.timeRemaining = initialTime
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
            timerCore()
        }
    }

    func appendTime( additionalTime: TimeInterval) {
        timeRemaining += additionalTime
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        timeRemaining = initialTime
    }
    
    func pauseUnpause() {
        isPaused.toggle()
    }
    
    func timerCore(){
        if statusAtual == .foco{
            statusAtual = .descanso
            initialTime = (pausaPersonalizada * 60)
        }
        else if statusAtual == .descanso{
            statusAtual = .foco
            initialTime = (tempoPersonalizado * 60)
        }
    }
}

