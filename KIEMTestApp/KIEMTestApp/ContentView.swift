//
//  ContentView.swift
//  KIEMTestApp
//
//  Created by Samuel on 2022/02/18.
//

import SwiftUI

struct ContentView: View {
    @State var text: String = ""
    var body: some View {
        VStack {
            Text("KIEM Test")
                .font(.largeTitle)
                .fontWeight(.bold)
        TextField("Enter string in Korean iput mode.", text: $text)
            .padding()
            .overlay(RoundedRectangle(cornerSize: .init(width: 5, height: 5)).stroke().foregroundColor(.blue))
            .padding()
        Text("👉  \(text.stringTypedInEnglishMode)")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
