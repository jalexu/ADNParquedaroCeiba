//
//  ExitVehicleView.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI
import Domain
import Combine

struct ExitVehicleView<ViewModel>: View where ViewModel: ExitVehicleProtocol {
    
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var valuesFieldsView: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Días:")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding([.top, .trailing, .leading], 20)
                Text(String(viewModel.state.daysToPay))
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding([.top, .trailing, .leading], 20)
            }
            
            HStack(spacing: 10) {
                Text("Horas:")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding([.top, .trailing, .leading], 20)
                Text(String(viewModel.state.hoursToPay))
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding([.top, .trailing, .leading], 20)
            }
            
            HStack(spacing: 10) {
                Text("Valor a pagar:")
                    .fontWeight(.black)
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
                    .padding([.top, .trailing, .leading], 20)
                Text(String(viewModel.state.valueToPay))
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.orange)
                    .padding([.top, .trailing, .leading], 20)
            }
            
        }
    }
    
    var searchButtonView: some View {
        Button {
            viewModel.searchVehicle()
        } label: {
            HStack(alignment: .center, spacing: 6) {
                Text("Buscar")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
    
    var payButtonView: some View {
        Button {
            viewModel.paymentVehicle()
        } label: {
            HStack(alignment: .center, spacing: 6) {
                Text("Pagar")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.cornerRadius(12))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if viewModel.state.valueToPay != 0 {
                        CircleImageView(imageName: "thanks")
                    }
                    
                    if !viewModel.state.showFildsPay {
                        VStack(alignment: .center, spacing: 20) {
                            TextField("Ingresa la placa", text: $viewModel.state.inputNumberPlaque)
                                .keyboardType(.asciiCapable)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding([.top, .trailing, .leading], 20)
                                .font(.system(size: 24))
                            
                            Spacer()
                            
                            searchButtonView
                                .padding(.bottom, 50)
                        }
                    } else {
                        valuesFieldsView
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        payButtonView
                            .frame(width: 180)
                            .padding(.top, 100)
                    }
                }
                .onDisappear {
                    viewModel.onDisappear()
                }
            }
            .background(Color("ColorBackground").ignoresSafeArea(.all, edges: [.bottom, .leading, .trailing]))
            
        }
        .navigationTitle(Constants.Title.parqueaderoTitle)
    }
}
