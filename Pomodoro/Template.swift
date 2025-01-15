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
        
        VStack {
            Text("Estatísticas")
                .font(.largeTitle)
                .padding()
            
            HStack(spacing:-16) {
                VStack {
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 150, height: 80)
                          .background(Color(red: 0.41, green: 0.64, blue: 0.93).opacity(0.13))
                          .cornerRadius(25)
                          .overlay(
                            RoundedRectangle(cornerRadius: 25)
                              .inset(by: 1.5)
                              .stroke(Color(red: 0.41, green: 0.64, blue: 0.93), lineWidth: 3)
                          )
                                                
                        VStack{
                            Text("\(ciclos)")
                                .font(.title)
                                .foregroundColor(.blue)
                            Text("Ciclos completos")
                                .font(.subheadline)
                        }
                    }
                }
                .padding()
                VStack {
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 150, height: 80)
                          .background(Color(red: 0.41, green: 0.64, blue: 0.93).opacity(0.13))
                          .cornerRadius(25)
                          .overlay(
                            RoundedRectangle(cornerRadius: 25)
                              .inset(by: 1.5)
                              .stroke(Color(red: 0.41, green: 0.64, blue: 0.93), lineWidth: 3)
                          )
                        VStack{
                            Text("25 mins")
                                .font(.title)
                                .foregroundColor(.red)
                            Text("Duração dos ciclos")
                                .font(.subheadline)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            Chart(cicloDiario){ point in
                BarMark(x: .value("Dia", formatDate(point.day)), y: .value("Ciclos",point.ciclos))
                
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
