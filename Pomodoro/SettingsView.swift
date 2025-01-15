//
//  SettingsView.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 07/01/25.
//
import SwiftUI


struct SettingsView: View{
    @State private var notificationsEnabled = true
    @State private var selectedSound = "Chime"
    @State private var selectedLanguage = "Portuguese"
    @State private var isDarkMode = false
    
    var body: some View {
        VStack {
            
            Text(localizedString("settings"))
                .font(.largeTitle)
                .padding()
            
            Form {
                Section(header: Text("Configurações de Tempo")) {
                    HStack {
                        Text("Tempo")
                        Slider(value: .constant(25), in: 5...60)
                    }
                    HStack {
                        Text("Intervalos")
                        Slider(value: .constant(5), in: 1...15)
                    }
                }
                
                Section(header: Text("Notificações")) {
                    Toggle("Habilitar notificações", isOn: $notificationsEnabled)
                    Picker("Som de alerta", selection: $selectedSound) {
                        Text("Chime").tag("Chime")
                        Text("Bell").tag("Bell")
                        Text("Buzz").tag("Buzz")
                    }
                }
                
                Section(header: Text(localizedString("language"))) {
                    Picker(localizedString("language"), selection: $selectedLanguage) {
                        Text("Portuguese").tag("Portuguese")
                        Text("English").tag("English")
                        Text("Spanish").tag("Spanish")
                        Text("French").tag("French")
                    }
                }
                
                Section(header: Text("Tema")) {
                    Toggle("Modo Escuro", isOn: $isDarkMode)
                        .onChange(of: isDarkMode){
                            value in
                            if value{
                                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                            }
                            else{
                                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                            }
                        }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark: .light)
        }
    }
    private func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

