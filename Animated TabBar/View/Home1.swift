//
//  Home1.swift
//  Animated TabBar
//
//  Created by Michele on 27/12/20.
//

import SwiftUI

struct Home1: View {
//    Total Amount
    @State var bill : CGFloat = 750
    @State var players = [
        Player(image: "animoji1", name: "Andy", bgColor: Color.green),
        Player(image: "animoji2", name: "Cody", bgColor: Color.gray),
        Player(image: "animoji3", name: "Steve", bgColor: Color.yellow)
    ]
    
    @State var pay = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                HStack{
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color.orange)
                            .padding()
                            .background(Color.black.opacity(0.25))
                            .cornerRadius(15)
                    })
                    Spacer()
                }
                .padding()
    //            Bill Card View
                VStack(spacing:15){
                    Button(action: {
                        
                    }, label: {
                        Text("Recipt")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,20)
                            .background(Color.purple)
                            .cornerRadius(12)
                    })
    //                Dotted Lines..
                    Line()
                        .stroke(Color.black,style: StrokeStyle(lineWidth: 1, lineCap: .butt, lineJoin: .miter,dash: [10]))
                        .frame(height: 1)
                        .padding(.horizontal)
                        .padding(.top,10)
                    
                    HStack{
                        
                        VStack(alignment: .leading, spacing: 12, content: {
                            Text("Title")
                                .font(.caption)
                            Text("Team Dinner")
                                .font(.title2)
                                .fontWeight(.heavy)
                        })
                        .foregroundColor(Color.purple)
                        .frame(maxWidth : .infinity)
                        
                        VStack(alignment: .leading, spacing: 12, content: {
                            Text("Total Bill")
                                .font(.caption)
                            Text("€\(Int(bill))")
                                .font(.title2)
                                .fontWeight(.heavy)
                        })
                        .foregroundColor(Color.purple)
                        .frame(maxWidth : .infinity)
                        .padding(.top,10)
                        
                    }
    //                Animoji Views
                    VStack {
                        HStack(spacing: -20){
                            ForEach(players){ payer in
                                Image(payer.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                    .padding(8)
                                    .background(payer.bgColor)
                                    .clipShape(Circle())
                                
                            }
                        }
                        Text("Splitting With")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }.frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(25)
                }
                .frame(maxWidth:.infinity)
                .padding()
                .background(Color.orange.clipShape(BillShape()).cornerRadius(25))
                .padding(.horizontal)
    //            Custom Slider
                ForEach(players.indices){ index in
                    PriceView(player: $players[index], totlaAmount: bill)
                    
                }
                Spacer(minLength: 15)
//                Pay button
                HStack{
                    HStack(spacing : 0) {
                        ForEach(1...6, id:\.self){ index in
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight :.heavy))
                                .foregroundColor(Color.white.opacity(Double(index) * 0.06))
                        }
                    }
                    .padding(.leading,45)
                    Spacer()
                    Button(action: {
                        pay.toggle()
                    }, label: {
                        Text("Confirm Split")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .padding(.horizontal,25)
                            .padding(.vertical,10)
                            .background(Color.purple)
                            .clipShape(Capsule())
                    })
                }
                .frame(height: 20)
                .padding()
                .background(Color.black.opacity(0.25))
                .clipShape(Capsule())
                .padding(.horizontal)
                Spacer()
                
            }
            
        }
        .background(Color.purple).ignoresSafeArea(.all,edges: .all)
        .alert(isPresented: $pay, content: {
            Alert(title: Text("Alert"),message: Text("Confirm to split pay"),
                  primaryButton: .default(Text("Pay"),action: {
                    
                  }),
                  secondaryButton: .destructive(Text("Cancel"),action: {
                    
                  }))
        })
    }
}

struct Home1_Previews: PreviewProvider {
    static var previews: some View {
        Home1()
    }
}
//Line Shape
struct Line : Shape {
    func path(in rect : CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}
//Sample Model and Data

