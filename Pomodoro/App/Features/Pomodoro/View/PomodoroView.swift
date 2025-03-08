//
//  PomodoroView.swift
//  Pomodoro
//
//  Created by Daniel Nobre on 20/02/25.
//
import SwiftUI

struct PomodoroView: View {
    @State private var height: CGFloat?
    @State private var solarRayViewModel: SolarRayViewModel  = .init(subdivisions: 8)
    
    @Binding var timerManager: TimerManager
    
    var body: some View {
        VStack {
            Text("Pomodoro")
                .font(.custom("Satoshi-Bold", size: 32))
                .padding(.bottom, 100)
            
            ZStack {
                ForEach($solarRayViewModel.rays) { ray in
                    SolarRays(height: height ?? 10, timeRemaining: Int(timerManager.timeRemaining), totalTime: Int(timerManager.initialTime), solarRayModel: ray)
                }
                
                CircleView(timerManager: $timerManager, height: $height)
                    .frame(width: 200, height: 200)
                    .background {
                        Color.yellow
                            .clipShape(Circle())
                    }
                
                Text(timerManager.formattedTime) // Corrigido aqui
                    .font(.custom("Satoshi-Bold", size: 48))
                    .foregroundStyle(.white)
                
                HStack(spacing: 50) {
                    ButtonStyle(name: timerManager.isPaused ? "Iniciar" : "Pausar", iconName: timerManager.isPaused ? "play.fill" : "pause.fill") {
                        toggleTimer()
                    }
                    .offset(y: 300)
                    
                    ButtonStyle(name: "Reiniciar", iconName: "arrow.counterclockwise") {
                        if !timerManager.isPaused {
                            timerManager.stopTimer()
                        }
                        timerManager.resetTimer()
                    }
                    .offset(y: 300)
                }
            }
            Spacer()
        }
        .onAppear {
            timerManager.startTimer()
        }
    }
    
    func toggleTimer() {
        if timerManager.timeRemaining <= 0 {
            timerManager.resetTimer()
            for i in 0..<solarRayViewModel.rays.count {
                solarRayViewModel.rays[i].initialSpacing = 0
            }
        }
        
        if timerManager.isPaused {
            timerManager.startTimer()
        } else {
            timerManager.stopTimer()
        }
    }
}

#Preview {
    let timerManager = TimerManager(initialTime: 20) // Removido TimerViewModel
    return PomodoroView(timerManager: .constant(timerManager))
}

