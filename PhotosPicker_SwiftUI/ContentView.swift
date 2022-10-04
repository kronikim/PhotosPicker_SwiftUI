//
//  ContentView.swift
//  PhotosPicker_SwiftUI
//
//  Created by deniz karahan on 4.10.2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var selectedImages : [PhotosPickerItem] = []
    @State var data : Data?
    
    var body: some View {
        VStack {
            if let data = data {
               if let selectedImage = UIImage(data:  data) {
                Spacer()

                Image(uiImage: selectedImage)
                .resizable()
                .frame(width: UIScreen.main.bounds.width * 0.8 ,height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                                 
                }
            }
            Spacer()
            PhotosPicker(selection: $selectedImages, maxSelectionCount: 1,  matching: .images){
                Text("Select Image from Photo Library")
            }.onChange(of: selectedImages, perform: { newValue in
                guard let image = selectedImages.first else { return }
                image.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data{
                            self.data = data
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            })
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
