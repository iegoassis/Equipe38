//
//  ButtonStyle.swift
//  Pomodoro
//
//  Created by Daniel Nobre on 20/02/25.
//

import SwiftUI

struct ButtonStyle: View {
    var name: String
    var iconName: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                VStack {
                    ZStack {
                        Circle()
                            .frame(width: 83, height: 83)
                        Image(systemName: iconName)
                            .bold()
                            .foregroundStyle(.white)
                            .font(.system(size: 32))
                    }
                    Text(name)
                        .font(.system(size: 22))
                        .bold()
                        .font(.custom("Satoshi-Bold", size: 22))
                }
            }

        }
    }
}

#Preview {
    ButtonStyle(name: "Iniciar", iconName: "play.fill") {
        print("oi")
    }
}
