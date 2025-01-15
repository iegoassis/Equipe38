//
//  SwiftUIView.swift
//  Pomodoro
//
//  Created by iredefbmac_20 on 09/01/25.
//

import SwiftUI

struct RetanguloPomodoro: View {
    @Binding var isRunning: Bool
    @Binding var timerValue: Int
    var body: some View {
        HStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(height:100)
                .padding(.top,60)
                .shadow(color: .black.opacity(0.25),radius: 1.5,x:0,y:4)
                .overlay{
                    HStack(spacing: 35){
                        VStack{
                            Button(action:{
                                isRunning = false
                            }){
                                ZStack{
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width:60,height:60)
                                    
                                    Image(systemName:"pause.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:30,height:30)
                                        .foregroundColor(.white)
                                }
                            }
                            Text("Pausar")
                        }
                        .padding(.top,50)
                        VStack{
                            Button(action:{
                                isRunning = true}) {
                                    ZStack{
                                        Circle()
                                            .fill(Color.blue)
                                            .frame(width:100,height:100)
                                        Image(systemName: "play.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width:40,height:40)
                                            .buttonStyle(.borderedProminent)
                                            .foregroundColor(.white)
                                    }
                                }
                            Text("Iniciar")
                                .padding(.top,0)
                        }
                        VStack{
                            Button(action:{
                            isRunning = false
                            timerValue = 25 * 60
                        }){
                            ZStack{
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width:60,height:60)
                                Image(systemName:"arrow.counterclockwise")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:30,height:30)
                                    .foregroundColor(.white)
                            }
                        }
                            Text("Reiniciar")
                        }
                        .padding(.top,50)
                    }
                }
                    
        }
    }
}

#Preview {
    RetanguloPomodoro(isRunning: .constant(false),timerValue: .constant(25*60))
}
