//
//  PaymentParkingView.swift
//  ADNParqueadero
//
//  Created by Jaime Alexander Uribe Uribe - Ceiba Software on 21/03/23.
//

import SwiftUI
import Domain
import Combine


struct PaymentParkingView<ViewModel>: View where ViewModel: PaymentParkingProtocol {
    @State var inputNumberPlaque: String = ""
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
   
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
    
    var valuesFieldsView: some View {
        VStack {
            HStack(spacing: 10) {
                Text("Días:")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
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
                    .foregroundColor(.black)
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
                    .foregroundColor(.black)
                    .padding([.top, .trailing, .leading], 20)
                    Text(String(viewModel.state.valueToPay))
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .padding([.top, .trailing, .leading], 20)
            }
            
        }
    }
    
    var searchButtonView: some View {
        Button {
            viewModel.searchVehicle(numberPlaque: inputNumberPlaque)
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
            viewModel.searchVehicle(numberPlaque: inputNumberPlaque)
        } label: {
            HStack(alignment: .center, spacing: 6) {
                Text("Pargar")
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
    
    var typeVehiclePickerView: some View {
            VStack(spacing: 0) {
                Text("Seleccione el tipo de vehículo a pagar")
                    .foregroundColor(.gray)
                
                Picker("Tipo de vehículo", selection: $viewModel.state.seletedVehicleType) {
                    ForEach(VehicleType.allCases, id: \.self) {
                        Text($0.rawValue)
                            .font(.system(size: 24))
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding([.top ,.trailing, .leading], 20)
    }
    
    var body: some View {
        ZStack{
            VStack {
                navigationTitleView
                    .padding(.horizontal, 15)
                    .padding(.bottom)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y:5)
                    .frame(maxWidth: .infinity)
                    .alert(isPresented: $viewModel.state.showMessage) {
                        Alert(
                            title: Text("NO REGISTRA"),
                            message: Text("Por favor intenta con otra placa."),
                            dismissButton: .cancel(Text("OK"))
                        )
                    }
                    .padding(.bottom, 50)
                    
                if !viewModel.state.showFildsPay {
                    typeVehiclePickerView
                    VStack(alignment: .center, spacing: 20) {
                        TextField("Ingresa la placa", text: $inputNumberPlaque)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding([.top, .trailing, .leading], 20)
                            .font(.system(size: 24))
                        
                        Spacer()
                        
                        searchButtonView
                            .padding(.bottom, 50)
                    }
                } else {
                    valuesFieldsView
                    Spacer()
                    
                    payButtonView
                        .padding(.bottom, 50)
                }
                
            }
            .background(Color("ColorBackground").ignoresSafeArea(.all,edges: .all))
        }
        
        .ignoresSafeArea(.all)
    }
}
