//
//  HomeView.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 07/01/25.
//
import SwiftUI

struct HomeView: View {
    @Binding var ciclos: Int
    @Binding var cicloDiario: [PomodoroPoint]
    @Binding var isRunning: Bool
    @Binding var tempoPersonalizado: Int
    @State private var completedCycles: [String] = []
    @State private var tempoInicial: Int = 0

    var body: some View {
        VStack {
            Text("Pomodoro")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text(formatTime(tempoPersonalizado))
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            RetanguloPomodoro(isRunning: $isRunning, tempoPersonalizado: $tempoPersonalizado)
            
            Text("Ciclos completos:")
                .padding(.top)
                .font(.pomodoroUI(.satoshiHeading1))
            
            List {
                ForEach(completedCycles, id: \.self) { cycle in
                    Text(cycle)
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            tempoInicial = tempoPersonalizado // Armazenar o tempo inicial ao carregar a tela
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isRunning && tempoPersonalizado > 0 {
                tempoPersonalizado -= 1
            } else if isRunning && tempoPersonalizado == 0 {
                completedCycles.append("Ciclo Completo!")
                tempoPersonalizado = tempoInicial // Reinicia para o tempo inicial configurado
                ciclos += 1
                
                let indexAtual = Calendar.current.component(.day, from: Date()) % 7
                cicloDiario[indexAtual].ciclos += 1
            }
        }
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TabBar()
}

// Retângulo com os botões de controle
