//
//  RingView.swift
//  DesignCode
//
//  Created by jinzhao wang on 2021/9/13.
//

import SwiftUI

struct RingView: View {
    var color1 = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    var color2 = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    var width: CGFloat = 44
    var height: CGFloat = 44
    var percent: CGFloat = 82
    @Binding var showCircle: Bool
    
    var body: some View {
        let multiplier = width / 44
        let progress = 1 - (percent / 100)
        
        return ZStack {
            Circle()
                .stroke(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.1),style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: showCircle ? progress : 1, to: 1.0)
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [Color(color1), Color(color2)]), startPoint: .topTrailing, endPoint: .bottomLeading),
                    style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
                )
                .animation(Animation.easeInOut.delay(0.3))
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0)
                )
                .frame(width: width, height: height)
                .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)).opacity(0.2), radius: 3 * multiplier, x: 1, y: 3 * multiplier)
            
            Text("\(Int(percent))%")
                .font(.system(size: 12 * multiplier))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .onTapGesture {
                    self.showCircle.toggle()
                }
        }
    }
}
 
struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(showCircle: .constant(true))
    }
}
