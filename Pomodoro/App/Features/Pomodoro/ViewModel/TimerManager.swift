//
//  TimerManager.swift
//  SolEquipe38
//
//  Created by Daniel Araujo Nobre on 06/02/25.
//

import SwiftUI
import Combine

class TimerManager: ObservableObject {
    @Published var initialTime: TimeInterval
    @Published var timeRemaining: TimeInterval
    @Published var isPaused: Bool = true
    @Published var ciclos: Int = 0
    private var timer: Timer?
    
    var formattedTime: String {
        let time = Int(timeRemaining)
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    init(initialTime: TimeInterval) {
        self.initialTime = initialTime
        self.timeRemaining = initialTime
    }
    
    func startTimer() {
        stopTimer()
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            resetTimer()
        }
    }
    
    func stopTimer() {
        isPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timeRemaining = initialTime
    }
}

