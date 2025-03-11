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
    
    @State private var selectedPause = 10
    @State private var selectedPomodoro = 25
    
    @ObservedObject var timerManager: TimerManager
    @Environment(\.colorScheme) var colorScheme

    let pauseOptions = [10, 5]
    let pomodoroOptions = [25, 15, 10, 1]

    var body: some View {
        NavigationView {
            VStack {
                Text("Configurações")
                    .font(.title)
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
        Section(header: Text("Pausas").font(.headline)) {
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
        let isSelected = selectedPause == option
        let backgroundColor: Color = isSelected ? .blue : (colorScheme == .dark ? .black : .white)
        let textColor: Color = isSelected ? .white : (colorScheme == .dark ? .white : .black)

        return Button(action: {
            selectedPause = option
            timerManager.initialTime = Double(option * 60)
        }) {
            Text("\(option)\nminutos")
                .bold()
                .foregroundColor(textColor)
                .frame(width: 75, height: 75)
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }

    private func pomodoroSettingsSection() -> some View {
        Section(header: Text("Tempo do pomodoro").font(.headline)) {
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
        let isSelected = selectedPomodoro == option
        let backgroundColor: Color = isSelected ? .blue : (colorScheme == .dark ? .black : .white)
        let textColor: Color = isSelected ? .white : (colorScheme == .dark ? .white : .black)

        return Button(action: {
            selectedPomodoro = option
            timerManager.initialTime = Double(option * 60)
            timerManager.resetTimer()
        }) {
            Text("\(option)\nminutos")
                .bold()
                .foregroundColor(textColor)
                .frame(width: 75, height: 75)
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }

    private func languageSettingsSection() -> some View {
        Section {
            HStack {
                Text("Idioma").font(.headline)
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
                Text("Som de Alerta").font(.headline)
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
            Toggle("Modo escuro", isOn: $isDarkMode)
                .onChange(of: isDarkMode) { value in
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = value ? .dark : .light
                }
        }
    }
}
