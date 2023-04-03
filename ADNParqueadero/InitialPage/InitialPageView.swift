//
//  InitialPageView.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI
import Factory

struct InitialPageView: View {
    
    @StateObject private var registerVehicleViewModel = Container.shared.injectRegisterVehicleViewModel()
    @StateObject private var exitVehicleViewModel = Container.shared.injectExitVehicleViewModel()
    
    var registerNavigationLink: some View {
        NavigationLink(
            destination: RegisterVehicleView(viewModel: registerVehicleViewModel),
            label: {
                HStack(alignment: .center, spacing: 6) {
                    Text("Registrar vehículo")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white.cornerRadius(12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                )
            })
    }
    
    var paymentNavigationLink: some View {
        NavigationLink(
            destination: ExitVehicleView(viewModel: exitVehicleViewModel),
            label: {
                HStack(alignment: .center, spacing: 6) {
                    Text("Pagar vehículo")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white.cornerRadius(12))
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1)
                )
            })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center, spacing: 60) {
                    registerNavigationLink
                    paymentNavigationLink
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Constants.Title.parqueaderoTitle)
                        .font(.headline)
                        .foregroundColor(.orange)
                    
                }
            }
            .background(MotionAnimationView()).ignoresSafeArea(.all, edges: [.bottom, .leading, .trailing])
        }
    }
}

#if DEBUG
struct InitialPageView_Previews: PreviewProvider {
    static var previews: some View {
        InitialPageView()
    }
}
#endif
