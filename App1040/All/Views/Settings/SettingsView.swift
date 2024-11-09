//
//  SettingsView.swift
//  App1040
//
//  Created by IGOR on 06/11/2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Settings")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold))
                    
                    Spacer()

                }
                .padding(.bottom, 20)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        Button(action: {
                            
                            SKStoreReviewController.requestReview()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("bg"))
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(width: 25, height: 25)
                                    .background(RoundedRectangle(cornerRadius: 5).fill(.white))
                                    .padding(.horizontal)
                                
                                Text("Rate us")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .medium))
                                
                                Spacer()
                                
                                Text("Rate")
                                    .foregroundColor(Color("bg"))
                                    .font(.system(size: 15, weight: .regular))
                                    .padding(6)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                            }
                            .padding()
                            .frame(height: 80)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                        })
                        
                        Button(action: {
                            
                            guard let url = URL(string: "https://www.termsfeed.com/live/7c8df4d1-5681-4739-9f15-c3d1fc48d004") else { return }
                            
                            UIApplication.shared.open(url)
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "person.badge.shield.checkmark.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 22, weight: .regular))
                                    .padding(.horizontal)
                                
                                Text("Usage Policy")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .medium))
                                
                                Spacer()
                                
                                Text("Read")
                                    .foregroundColor(Color("bg"))
                                    .font(.system(size: 15, weight: .regular))
                                    .padding(6)
                                    .padding(.horizontal, 5)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                            }
                            .padding()
                            .frame(height: 80)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")))
                        })
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
