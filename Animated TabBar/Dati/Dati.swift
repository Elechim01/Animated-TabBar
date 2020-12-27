//
//  Dati.swift
//  Animated TabBar
//
//  Created by Michele on 27/12/20.
//

import Foundation
import SwiftUI
struct Player : Identifiable {
    var id = UUID().uuidString
    var image: String
    var name : String
    var bgColor : Color
//  Offset For Custom Progress View
    var offset : CGFloat = 0
}
//Custom bill Card Sahpe
struct BillShape : Shape {
    func path(in rect : CGRect) -> Path {
        return Path{ path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
              
            path.move(to: CGPoint(x: 0, y: 80))
            path.addArc(center: CGPoint(x: 0, y: 80), radius: 20, startAngle: .init(degrees: -90), endAngle: .init(degrees: 90), clockwise: false)
            
            path.move(to: CGPoint(x: rect.width, y: 80))
            path.addArc(center: CGPoint(x: rect.width, y: 80), radius: 20, startAngle: .init(degrees: 90), endAngle: .init(degrees: -90), clockwise: false)
            
        }
    }
}
