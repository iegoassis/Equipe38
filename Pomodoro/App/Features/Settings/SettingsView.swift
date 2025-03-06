//
//  SettingsView.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 07/01/25.
//
import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var selectedSound = "navi-song.mp3"
    @State private var selectedLanguage = "Português"
    @State private var isDarkMode = false

    @State private var tempoPersonalizado: Int = 0
    @State private var pausaPersonalizada: Int = 0
    @State private var selectedPause = 10
    @State private var selectedPomodoro = 25
    
    @Binding var timerManager: TimerManager

    let pauseOptions = [10, 5]
    let pomodoroOptions = [25, 15, 10, 1]

    var body: some View {
        NavigationView {
            VStack {
                Text("Configurações")
                    .font(.pomodoroUI(.satoshiHeading1))
                    .padding(.top, 20)

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        pauseSettingsSection()
                        pomodoroSettingsSection()
                        languageSettingsSection()
                        soundSettingsSection()
                        toggleSettingsSection()
                    }
                    .padding()
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }

    private func pauseSettingsSection() -> some View {
        Section(header: Text("Pausas").font(.pomodoroUI(.satoshiHeading3))) {
            HStack {
                Spacer()
                ForEach(pauseOptions, id: \.self) { option in
                    pauseButton(for: option)
                }
                Spacer()
            }
        }
    }

    private func pauseButton(for option: Int) -> some View {
        Button(action: {
            selectedPause = option
            showPomodoro(minutes: option)
            
            timerManager.initialTime = Double(option * 60)
        }) {
            Text("\(option)\nminutos")
                .font(.pomodoroUI(.satoshiBody2Medium))
                .bold()
                .foregroundColor(selectedPause == option ? .white : .black)
                .frame(width: 75, height: 75)
                .background(selectedPause == option ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }

    private func pomodoroSettingsSection() -> some View {
        Section(header: Text("Tempo do pomodoro").font(.pomodoroUI(.satoshiHeading3))) {
            HStack {
                Spacer()
                ForEach(pomodoroOptions, id: \.self) { option in
                    pomodoroButton(for: option)
                }
                Spacer()
            }
        }
    }

    private func pomodoroButton(for option: Int) -> some View {
        Button(action: {
            selectedPomodoro = option
            showPomodoro(minutes: option)
            
            timerManager.initialTime = Double(option * 60)
            timerManager.resetTimer()
        }) {
            Text("\(option)\nminutos")
                .font(.pomodoroUI(.satoshiBody2Medium))
                .foregroundColor(selectedPomodoro == option ? .white : .black)
                .frame(width: 75, height: 75)
                .background(selectedPomodoro == option ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }

    private func languageSettingsSection() -> some View {
        Section {
            HStack {
                Text("Idioma")
                    .font(.pomodoroUI(.satoshiHeading3))
                Spacer()
                Picker("Idioma", selection: $selectedLanguage) {
                    Text("Português").tag("Português")
                    Text("Inglês").tag("Inglês")
                }
                .pickerStyle(MenuPickerStyle())
            }
        }
    }

    private func soundSettingsSection() -> some View {
        Section {
            HStack {
                Text("Som de Alerta")
                    .font(.pomodoroUI(.satoshiHeading3))
                Spacer()
                Text(selectedSound)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.down")
                }
            }
        }
    }

    private func toggleSettingsSection() -> some View {
        Section {
            Toggle("Notificações", isOn: $notificationsEnabled)
                .font(.pomodoroUI(.satoshiHeading3))
            Toggle("Modo escuro", isOn: $isDarkMode)
                .font(.pomodoroUI(.satoshiHeading3))
                .onChange(of: isDarkMode) { value in
                    if value {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                    } else {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                    }
                }
        }
    }

    func showPomodoro(minutes: Int) {
        tempoPersonalizado = minutes
        pausaPersonalizada = minutes
    }
}



class TimerViewModel{
    enum timeTypes{
        case atividade,descanso
    }
    var estadoTimer: timeTypes = .atividade
    private var timer: TimerManager = .init(initialTime: 100)
    
    var tempoAtividade: Double = 100
    var tempoDescanso: Double = 10
    
    func mudarEstadoTimer(){
        switch estadoTimer{
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
    func resetarTimer(){
        timer.resetTimer()
    }
    func getTimer() -> TimerManager{
        return timer
    }
}
