//
//  TabBar.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 07/01/25.
//
import SwiftUI
struct TabBar: View{
    @StateObject var timerViewModel = TimerViewModel()
    @StateObject var timerManager: TimerManager = TimerManager(initialTime: 20)
    @StateObject var contarTempo: ContarTempo
    @State private var ciclos: Int = 0
    @State private var cicloDiario: [PomodoroPoint] = [
        PomodoroPoint(day: Date().addingTimeInterval(-172800), ciclos: 7),
        PomodoroPoint(day: Date().addingTimeInterval(-86400), ciclos: 2),
        PomodoroPoint(day: Date(), ciclos: 5),
        PomodoroPoint(day: Date().addingTimeInterval(86400), ciclos:1),
        PomodoroPoint(day: Date().addingTimeInterval(172800), ciclos: 3),
        PomodoroPoint(day: Date().addingTimeInterval(259200), ciclos: 8),
        PomodoroPoint(day: Date().addingTimeInterval(345600), ciclos: 1)]
    @State private var isRunning = false
    @State private var tempoPersonalizado: Int = 25
    //Array(repeating: PomodoroPoint(day:Date(),ciclos: 0),count: 7)
    var body: some View {
        TabView{
            PomodoroView(timerManager: timerManager,contarTempo: contarTempo, timerViewModel: timerViewModel)
                .tabItem {
                    Label("Pomodoro", systemImage: "timer")
                }
            
            Template(ciclos: ciclos, cicloDiario: cicloDiario,timerManager: timerManager,contarTempo: contarTempo)
                .tabItem {
                    Label("Estatísticas", systemImage: "chart.bar")
                }
            
            SettingsView(timerManager: timerManager)
                .tabItem {
                    Label("Configurações", systemImage: "gear")
                }
        }
    }
}
#Preview {
    TabBar(contarTempo: ContarTempo(timerViewModel: TimerViewModel()))
}
