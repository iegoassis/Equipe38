//
//  Template.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 07/01/25.
//
import SwiftUI
import Charts

struct Template: View{
    var ciclos: Int
    var cicloDiario: [PomodoroPoint]
    @ObservedObject var timerManager: TimerManager
    @ObservedObject var contarTempo: ContarTempo
    @State var semanaEscolhida: Int = 0
    var body: some View {
        
        VStack {
            Text("Estatísticas")
                .font(.pomodoroUI(.satoshiHeading1))
                .padding()
            Text("Diária")
                .font(.pomodoroUI(.satoshiHeading3))
                .frame(maxWidth: .infinity,alignment: .leading)
            HStack(spacing:-16) {
                VStack {
                    ZStack{
                        Rectangle()
                          .foregroundColor(.blue)
                          .frame(width: 175, height: 88)
                          .cornerRadius(25)
                          .overlay(
                            RoundedRectangle(cornerRadius: 25)
                              .inset(by: 1.5)
                              .stroke(Color(red: 0.41, green: 0.64, blue: 0.93), lineWidth: 3)
                          )
                                                
                        VStack(spacing:10){
                            Text("Ciclos de Foco completos")
                                .font(.pomodoroUI(.satoshiBody2Medium))
                                .foregroundColor(.white)
                            Text("\(contarTempo.cicloFoco)")
                                .font(.pomodoroUI(.satoshiBody1Medium))
                                .foregroundColor(.white)
                            
                        }
                    }
                }
                .padding()
                VStack {
                    ZStack{
                        Rectangle()
                          .foregroundColor(.blue)
                          .frame(width: 175, height: 88)
                          .cornerRadius(25)
                        VStack(spacing:10){
                            
                            Text("Ciclos de Descanso completos")
                                .font(.pomodoroUI(.satoshiBody2Medium))
                                .foregroundColor(.white)
                            Text("\(contarTempo.cicloDescanso)")
                                .font(.pomodoroUI(.satoshiBody1Medium))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            Text("Semanal")
                .font(.pomodoroUI(.satoshiHeading3))
                .frame(maxWidth: .infinity,alignment: .leading)
            HStack {
                Button(action: { semanaEscolhida -= 1 }) {
                    Image(systemName: "chevron.left").padding()
                }
                Text("\(getWeekLabel())")
                Button(action: { semanaEscolhida += 1 }) {
                    Image(systemName: "chevron.right").padding()
                }
            }
            Chart(cicloDiario){ point in
                BarMark(x: .value("Dia", formatDate(point.day)), y: .value("Ciclos",point.ciclos))
                
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height:300)
            Text("Gráfico de desempenho")
                .fontWeight(.bold)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
                .foregroundColor(Color.white)
        }
        .padding()
    }
    private func getWeeklyData() -> [PomodoroPoint] {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(byAdding: .weekOfYear, value: semanaEscolhida, to: Date())!
            return (0..<7).map { offset in
                let date = calendar.date(byAdding: .day, value: offset, to: startOfWeek)!
                return cicloDiario.first { calendar.isDate($0.day, inSameDayAs: date) } ?? PomodoroPoint(day: date, ciclos: 0)
            }
        }

        private func getWeekLabel() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, yyyy"
            return "\(semanaEscolhida + 1)º sem, \(formatter.string(from: Date()))"
        }

        private func getWeeklyTotal() -> Int {
            return getWeeklyData().reduce(0) { $0 + $1.ciclos }
        }

        private func getWeeklyAverage() -> String {
            let total = getWeeklyTotal()
            let mediaMinutos = (total * 25) % 60
            let mediaHoras = (total * 25) / 60
            return "\(mediaHoras)h \(mediaMinutos)min"
        }

        private func getMaxCiclos() -> Int {
            return getWeeklyData().max(by: { $0.ciclos < $1.ciclos })?.ciclos ?? 0
        }
    private func formatDate(_ inputDate : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: inputDate)
    }
}
