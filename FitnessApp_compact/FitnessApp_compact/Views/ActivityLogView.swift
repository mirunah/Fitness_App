//
//  ActivityLogView.swift
//  FitnessApp_compact
//
//  Created by Miruna-Ioana Haiduc on 17.06.2023.
//

import SwiftUI

struct ActivityLogView: View {
    @State private var isShareSheetShowing = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to Fitness App!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                    .padding(.top, 20)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text("This is your personal fitness companion! Now, you can take control of your fitness journey by creating custom challenges tailored to your goals and preferences.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.secondary)
                
                Text("Get started by setting up your own challenges based on various activities. Define the duration of your challenges and increase the number of workout sets to make them suit your needs.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.secondary)
                
                //Spacer()
                
                Button(action: {
                    isShareSheetShowing = true
                }) {
                    Text("Share")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.green)
                        )
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                }
                .padding(.vertical, 20)
                .sheet(isPresented: $isShareSheetShowing) {
                    ActivityView(activityItems: ["Check out this amazing Fitness App! #FitnessApp"])
                }
//                
                Text("If you enjoyed the app, feel free to share it with your friends.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .lineSpacing(4)
                    .opacity(0.8)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(.tertiarySystemBackground))
                    .shadow(radius: 10)
            )
            .padding()
        }
        .preferredColorScheme(.light)
    }
}

//struct ActivityLogView_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityLogView()
//    }
//}
//
//struct ActivityView: UIViewControllerRepresentable {
//    let activityItems: [Any]
//
//    func makeUIViewController(context: Context) -> UIActivityViewController {
//        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
//}
