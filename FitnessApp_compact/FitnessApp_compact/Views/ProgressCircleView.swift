//
//  ProgressCircleView.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 16.06.2023.
//

import SwiftUI

struct ProgressCircleView: View {
    let viewModel: ProgressCircleViewModel
    @State private var percentage: CGFloat = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.circleOutline)
                .frame(width: 80, height: 80)
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(style: .init(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .fill(Color.circleaTrack)
                .rotationEffect(.init(degrees: -90))
                .frame(width: 80, height: 80)
            VStack {
                if viewModel.shouldShowTitle {
                    Text(viewModel.title)
                }
                    Text(viewModel.message)
            }.padding(20)
                .font(Font.caption.weight(.semibold))
        }.onAppear {
            withAnimation(.spring(response: 4)) {
                percentage = CGFloat(viewModel.percentageComplete)
            }
        }
    }
}


//struct ProgressCircleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressCircleView(viewModel: .init(title: "Day", message: "3 of 7", percentageComplete: 0.43))
//            //.frame(width: 200, height: 200)
//            .preferredColorScheme(.dark)
//    }
//}
