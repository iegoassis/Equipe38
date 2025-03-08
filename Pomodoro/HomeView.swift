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
    @Binding var pausaPersonalizada: Int
    @Binding var timerManager: TimerManager
    @Binding var contarTempo: ContarTempo
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
            
            Text("Ciclos completos: \(completedCycles.count)") // Atualiza com os ciclos reais
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
            timerManager.initialTime = TimeInterval(tempoPersonalizado)
            timerManager.resetTimer()
            tempoInicial = tempoPersonalizado
        }
        .onChange(of: $contarTempo.contarCiclos) { novoValor in
            completedCycles.append("Ciclo \(novoValor) concluído em \(Date())")
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
