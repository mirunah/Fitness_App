//
//  ChallengeListView.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 12.06.2023.
//

import SwiftUI

struct ChallengeListView: View {
    @StateObject private var viewModel = ChallengeListViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry") {
                        viewModel.send(action: .retry)
                    }
                    .padding(10)
                    .background(Rectangle().fill(Color.red).cornerRadius(5))
                }
            } else {
                mainContentView
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.significantTimeChangeNotification)) { _ in
                        viewModel.send(action: .timeChange)
                    }
            }
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 20), .init(.flexible())], spacing: 20) {
                    ForEach(viewModel.itemViewModels, id: \.id) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                }
                Spacer()
            }.padding(10)
        }
        .sheet(isPresented: $viewModel.showingCreateModel) {
            NavigationView {
                CreateView()
            }.preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label : {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .navigationTitle(viewModel.title)
    }
}
