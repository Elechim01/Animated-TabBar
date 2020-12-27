//
//  Home.swift
//  Animated TabBar
//
//  Created by Michele on 27/12/20.
//

import SwiftUI

struct Home: View {
    @State var selectedtab = "house"
    init() {
        UITabBar.appearance().isHidden = true
    }
//    Location For Each Curve
    @State var xAxis : CGFloat = 0
    
    @Namespace var animation
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedtab){
                Color.red
                    .ignoresSafeArea(.all,edges: .all)
                    .tag("house")
                Color("color1")
                    .ignoresSafeArea(.all,edges: .all)
                    .tag("archivebox")
                Color.purple
                    .ignoresSafeArea(.all,edges: .all)
                    .tag("bell")
                Color.blue
                    .ignoresSafeArea(.all,edges: .all)
                    .tag("message")
                
            }
//            creiamo la tab bar
            HStack(spacing: 0){
                ForEach(tabs,id:\.self){ image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedtab = image
                                xAxis = reader.frame(in: .global).minX
                            }
                        }, label: {
                            Image(systemName: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(selectedtab == image ? getColor(image: image) : Color.gray)
                                .padding(selectedtab == image ? 15 : 0)
                                .background(Color.white.opacity(selectedtab == image ? 1 : 0).clipShape(Circle()))
                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x:  selectedtab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0,
                                        y: selectedtab == image ? -50 : 0)
                            
                        })
                        .onAppear{
                            if image == tabs.first{
                                xAxis = reader.frame(in: .global).minX
                            }
                        }
                    }
                    .frame(width: 25, height: 30)
                    if image != tabs.last{Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal,30)
            .padding(.vertical)
            .background(Color.white.clipShape(CustomShape(xAxis: xAxis)).cornerRadius(12))
            .padding(.horizontal)
//            Bottom Edge..
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            
        }
        .ignoresSafeArea(.all,edges: .bottom)
    }
    func getColor(image : String) -> Color{
        switch image {
        case "house":
            return Color.red
        case "archivebox":
            return Color("color1")
        case "bell" :
            return Color.purple
        default:
            return Color.blue
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
        }
    }
}
var tabs = ["house","archivebox","bell","message"]
//Curve
struct CustomShape : Shape{
    var xAxis: CGFloat
//    animating Path
    var animatedData : CGFloat{
        get{ return xAxis }
        set{ xAxis = newValue }
    }
    func path(in rect : CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
            
        }
    }
}
