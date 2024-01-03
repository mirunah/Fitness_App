//
//  ContentView.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 20.05.2023.
//

import SwiftUI

struct LandingView: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(size: 64, weight: .medium))
            .foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            viewModel.createPushed = true
        }) {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: viewModel.createButtonImageName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Text(viewModel.createButtonTitle)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding(10)
        .buttonStyle(PrimaryButtonStyle())
    }
    
    var alreadyButton: some View {
        Button(viewModel.alreadyButtonTitle) {
            viewModel.loginSignupPushed = true
        }.foregroundColor(.white)
    }
    
    var backgroundImage: some View {
        Image(viewModel.backgroundImageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(Color.black.opacity(0.2))
    }
   
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer().frame(height: proxy.size.height * 0.7)
                    title
                    NavigationLink(destination: CreateView(), isActive: $viewModel.createPushed) { //here is the link to the next page when pressing on the create challenge button
                        createButton
                    }
                    
                    NavigationLink(
                        destination: LoginSignupView(
                            mode: .login,
                            isPushed: $viewModel.loginSignupPushed
                        ),
                        isActive: $viewModel.loginSignupPushed
                    ) {}
                  alreadyButton
                }.padding(.bottom, 25)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity)
                .background(
                    backgroundImage
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            } //this makes the image size ok for all devices
        }.accentColor(.primary) //this makes colors in darkmode appear in primary color
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 14 Pro")
    }
}
