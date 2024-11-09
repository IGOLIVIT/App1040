//
//  AddSwimPool.swift
//  App1040
//
//  Created by IGOR on 07/11/2024.
//

import SwiftUI

struct AddSwimPool: View {

    @StateObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("Add photo")
                        .foregroundColor(.white.opacity(0.9))
                        .font(.system(size: 20, weight: .medium))
                    
                    HStack {
                        
                        Button(action: {
                            
                            viewModel.phName = ""
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .medium))
                            
                        })
                        
                        Spacer()

                    }
                }
                .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 12) {
                        
                        Text("Swim pool")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .medium))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(content: {
                            
                            Text("Enter")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                                .opacity(viewModel.phName.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.phName)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .medium))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.4)))
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack {

                                ForEach(viewModel.photos, id: \.self) { index in
                                
                                    Button(action: {
                                        
                                        viewModel.currentPhoto = index
                                        
                                    }, label: {
                                        
                                        Image(index)
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                            .padding(2)
                                            .background(RoundedRectangle(cornerRadius: 15.0).fill(Color("prim").opacity(viewModel.currentPhoto == index ? 1 : 0)))
                                    })
                                }
                                
                            }
                        }
                        .frame(height: 140)

                    }
                }
                
                Button(action: {
                    
                    viewModel.phImage = viewModel.currentPhoto
                    
                    viewModel.addImage()
                    
                    viewModel.phName = ""
                    viewModel.currentPhoto = ""
                    
                    viewModel.fetchImages()
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = false
                    }
                    
                }, label: {
                    
                    Text("Save")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("prim")))
                })
                .opacity(viewModel.phName.isEmpty || viewModel.currentPhoto.isEmpty ? 0.5 : 1)
                .disabled(viewModel.phName.isEmpty || viewModel.currentPhoto.isEmpty ? true : false)
            }
            .padding()
        }
    }
}

#Preview {
    AddSwimPool(viewModel: HomeViewModel())
}
