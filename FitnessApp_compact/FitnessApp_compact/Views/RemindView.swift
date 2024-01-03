//
//  RemindView.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 04.06.2023.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            //Spacer() //uncomment this if you want to have it in the middle of the screen
         //   DropdownView()
            Spacer()
            Button(action: {}) {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 15)
            Button(action: {}) {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
        }.navigationTitle("Remind")
    }
}

struct Previews_RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}
