//
//  PriceView.swift
//  Animated TabBar
//
//  Created by Michele on 27/12/20.
//

import SwiftUI

struct PriceView: View {
    @Binding var player : Player
    var totlaAmount : CGFloat
    
    var body: some View {
        VStack(spacing : 15){
            HStack{
                Image(player.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .padding(5)
                    .background(player.bgColor)
                    .clipShape(Circle())
                Text(player.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                Text(getPrice())
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                Capsule()
                    .fill(Color.black.opacity(0.25))
                    .frame(height: 30)
                Capsule()
                    .fill(player.bgColor)
                    .frame(width : player.offset + 20  ,height: 30)
//                Dots
                HStack(spacing: (UIScreen.main.bounds.width
                 - 100)/12){
                    ForEach(0..<12,id: \.self){ index in
                        Circle()
                            .fill(Color.white)
                            .frame(width: index % 4 == 0 ? 7 : 4, height: index % 4 == 0 ? 7 : 4)
                        
                    }
                }
                .padding(.leading)
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 35,height: 35)
                    .background(Circle().stroke(Color.white,lineWidth: 5))
                    .offset(x: player.offset)
                    .gesture(DragGesture().onChanged({ (value) in
//                        Padding Horizzontal ....
//                        Padding Horizzontal = 30
//                        Circle Radius = 20
//                        Total 50
                        if value.location.x > 20 && value.location.x <= UIScreen.main.bounds.width - 50{
//                            Circle Radius = 20
                            player.offset = value.location.x - 20
                        }
                    }))
            })
        }.padding()
    }
    func getPrice() -> String {
        let percent = player.offset / (UIScreen.main.bounds.width - 70)
        let amount = percent * (totlaAmount / 3)
        return String(format: "%.2f", amount)
    }
}

struct PriceView_Previews: PreviewProvider {
     @State static var player = Player(image: "", name: "", bgColor: Color.green)
    static var previews: some View {
        PriceView(player: $player, totlaAmount: 77)
    }
}
