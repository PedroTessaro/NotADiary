//
//  EntryView.swift
//  NotADiary
//
//  Created by Pedro Augusto on 06/10/25.
//

import SwiftUI
import CloudKit

struct EntryView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = EntryViewModel()
    
    @State var ckViewModel = CloudKitViewModel()
    
    @State private var isLoading: Bool = true
    @State private var wasClicked: Bool = false
    @State private var showingAlert1: Bool = false
    @State private var showingAlert2: Bool = false
    @State private var isLoadingLocal: Bool = false
    
    @State private var state: Int = 0
    
    @ViewBuilder func loadingView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
            .scaleEffect(2.0, anchor: .center)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    isLoading = false
                }
            }
    }
    
    var body: some View {
        if isLoading {
            loadingView()
        }
        else {
            if state == 0 {
                NavigationStack {
                    VStack {
                        Text("Já tem uma conta ou deseja criar uma?")
                            .font(.title2)
                        
                        HStack {
                            Button {
                                if !ckViewModel.isLogged {
                                    showingAlert1 = true
                                }
                                else {
                                    state = 1
                                    isLoading = true
                                }
                            } label: {
                                Text("Já tenho")
                            }
                            .buttonStyle(.bordered)
                            .alert("Já possui conta", isPresented: $showingAlert1) {
                                Button("OK", role: .confirm) {}
                            } message: {
                                Text("Você não possui uma conta ou não está conectado ao iCloud")
                            }
                            
                            Button {
                                if !viewModel.isSignedInToiCloud || ckViewModel.isLogged {
                                    showingAlert2 = true
                                }
                                else {
                                    state = 2
                                    isLoading = true
                                }
                            } label: {
                                Text("Ainda não tenho")
                            }
                            .buttonStyle(.bordered)
                            .alert("Já possui conta", isPresented: $showingAlert2) {
                                Button("OK", role: .confirm) {}
                            } message: {
                                Text("Você não está conectado no iCloud ou já possui uma conta!")
                            }
                        }
                    }
                    .navigationTitle("Boas vindas")
                }
            }
            else {
                if isLoading {
                    loadingView()
                }
                else {
                    if state == 1 {
                        HomeScreenView()
                            .environment(ckViewModel)
                    }
                    else if state == 2 {
                        OnboardingView(state: $state, isLoading: $isLoading)
                            .environment(ckViewModel)
                    }
                }
            }
        }
    }
}


#Preview {
    EntryView()
}
