//
//  ContentView.swift
//  CS193p-2023
//
//  Created by Tran Lam on 16/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
        }
        .padding()
    }
}

struct CardView: View {

    @State var isFaceUp: Bool = true

    var body: some View {
        ZStack(content: {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2)
                Text("👻").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.orange)
            }
        })
        .foregroundColor(.orange)
        .imageScale(.small)
    }
}

#Preview {
    ContentView()
}
