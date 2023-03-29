//
//  InitialPageView.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI
import Resolver

struct InitialPageView: View {
    
    var navigationTitleView: some View {
        HStack(spacing: 4) {
            Spacer()
            Text("Parqueadero ADN")
                .font(.title3)
                .fontWeight(.black)
                .foregroundColor(.black)
            Image(systemName: "flag.2.crossed")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 10, alignment: .center)
            Spacer()
        }
    }
    
    var registerNavigationLink: some View {
        NavigationLink(
            destination: RegisterVehicleView(viewModel: Resolver.resolve(RegisterVehicleViewModel.self)),
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
            destination: ExitVehicleView(viewModel: Resolver.resolve(ExitVehicleViewModel.self)),
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
            ZStack{
                VStack {
                    navigationTitleView
                        .padding(.bottom)
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .background(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y:5)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        registerNavigationLink
                        
                        paymentNavigationLink
                    }
                    .padding(.bottom, 50)
                    
                    Spacer()
                    
                }
                .background(Color("ColorBackground").ignoresSafeArea(.all,edges: .all))
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct InitialPageView_Previews: PreviewProvider {
    static var previews: some View {
        InitialPageView()
    }
}
