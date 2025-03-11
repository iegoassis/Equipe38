//
//  SolarRays.swift
//  aaaa
//
//  Created by Ian Pacini on 05/02/25.
//

import SwiftUI

struct SolarRays: View {
    var height: CGFloat
    var timeRemaining: Double
    var totalTime: Double
    
    @Binding var solarRayModel: SolarRayModel
    
    var body: some View {
        ZStack {
            VStack {
                sunRayShape()
                    .frame(width: 12, height: 50)
                    .foregroundStyle(.yellow)
                
                Spacer()
            }
            .frame(width: 12, height: height+solarRayModel.initialSpacing)
            .rotationEffect(Angle(degrees: Double(-(360/8) * solarRayModel.subdivision)))
            .onChange(of: timeRemaining) { oldValue, newValue in
                if passedCurrentAngle(solarRayModel.subdivision) {
                    withAnimation {
                        solarRayModel.initialSpacing = 140
                    }
                }
            }
        }
    }
    
    private func updatingInitialSpacing() {
        let progress = Double(timeRemaining) / Double(totalTime)
        
        let maxSpacing: CGFloat = 140
        solarRayModel.initialSpacing = maxSpacing * CGFloat(1 - progress)
    }
    
    private func passedCurrentAngle(_ value: Int) -> Bool {
        Angle(degrees: Double((360/8) * value)) >= Angle(degrees: Double((360/20) * timeRemaining))
    }
}

private struct sunRayShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: rect.width/2, startAngle: .degrees(0), endAngle: .degrees(-180), clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        return path
        
    }
}

//#Preview {
//    SolarRays(height: 120, timeRemaining: 20, totalTime: <#Int#>, solarRayModel: .constant(.init( subdivision: 3)))
//}
