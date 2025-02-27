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
    var body: some View {
        
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
                            Text("Ciclos completos")
                                .font(.pomodoroUI(.satoshiBody2Medium))
                                .foregroundColor(.white)
                            Text("\(ciclos)")
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
                            
                            Text("Duração dos ciclos")
                                .font(.pomodoroUI(.satoshiBody2Medium))
                                .foregroundColor(.white)
                            Text("25 mins")
                                .font(.pomodoroUI(.satoshiBody1Medium))
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            Chart(cicloDiario){ point in
                BarMark(x: .value("Dia", formatDate(point.day)), y: .value("Ciclos",point.ciclos))
                
            }
            .chartYAxis {
                AxisMarks(position: .leading) // Isso move os rótulos para a esquerda
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
    private func formatDate(_ inputDate : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: inputDate)
    }
}

            
            Spacer()
            Chart(cicloDiario){ point in
                BarMark(x: .value("Dia", formatDate(point.day)), y: .value("Ciclos",point.ciclos))
                
            }
            .chartYAxis {
                AxisMarks(position: .leading) // Isso move os rótulos para a esquerda
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
    private func formatDate(_ inputDate : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: inputDate)
    }
}
