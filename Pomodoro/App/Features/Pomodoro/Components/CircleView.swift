//
//  Circle.swift
//  aaaa
//
//  Created by Ian Pacini on 05/02/25.
//

import SwiftUI

struct CircleView: View {
    @Binding var timerManager: TimerManager
    @Binding var height: CGFloat?
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Circle()
                    .stroke(Color.yellow, lineWidth: 12)
                Circle()
                    .trim(from: 0, to: 1 - timerManager.timeRemaining/timerManager.initialTime)
                    .stroke(Color(.raiodeSolEscuro), lineWidth: 12)
                    .rotationEffect(Angle(degrees: -90))
            }
            .onAppear {
                self.height = proxy.frame(in: .local).height
            }
        }
    }
}

#Preview {
    let viewModel = TimerViewModel()
    CircleView(timerManager: .constant(.init(initialTime: 20, timerViewModel: viewModel)), height: .constant(10))
        .background {
            Color.yellow
                .clipShape(Circle())
        }
}
