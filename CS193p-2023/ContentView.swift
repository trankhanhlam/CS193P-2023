//
//  ContentView.swift
//  CS193p-2023
//
//  Created by Tran Lam on 16/11/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👺", "😱", "☠️", "🍭"]
    @State var cardCount = 4
    var body: some View {
        // Note: Không thể dùng for trong các Stack. Đọc bên dưới để biết trong ViewBuilder support những loại nào
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjuster
        }
        .padding()
    }

    var cards: some View {
        // minimum size của grid item sẽ là 120
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjuster: some View  {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle) // Tại sao lại set font ở đây. Do Image (dùng của system name) -> Hệ thống sẽ scale image tới cái font được set -> Để image được gần bằng với font chữ. -> Font chữ to -> Ảnh system to
    }

    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .imageScale(.large)
        .font(.largeTitle) // Tại sao lại set font ở đây. Do Image (dùng của system name) -> Hệ thống sẽ scale image tới cái font được set -> Để image được gần bằng với font chữ. -> Font chữ to -> Ảnh system to
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }

    var cardRemover: some View  {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }

    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View {
    var content: String = "👻"
    @State var isFaceUp: Bool = true // Khi mark với @State là đang tạo ra biến này là 1 tham chiếu (pointer)
    /*Tại sao lại cần @State:
     Về cơ bản ở ViewBuilder bên dưới khi muốn thay đổi biến thuộc Struct là không thể vì biến ở trong Struct sẽ là immutable.

     Khi tạo ra biến sẽ cấp phát cho nó 1 vùng trên bộ nhớ, ở trên struct thì biến này ko thể thay đổi.
     -> Tại sao không thể thay đổi: isFaceUp là 1 biến của struct và body thực chất cũng là 1 biến của struct ( ở đây là CardView)
     Không thể dùng 1 biến để thay đổi 1 biến. (Note: line 28-30 có thể sai vì thực chất đéo hiểu đoạn này lắm đâu)


     Tạo ra biến với @State là tạo ra 1 tham chiếu tới 1 giá trị nào đó. Nên về lý thuyết khi thay đổi như code ở dòng 53 thì đang thay đổi nơi nó tham chiếu tới (chỗ memory gì đó) chứ không thay đổi pointer
     */
    var body: some View {
        // ở đây không phải là ViewBuilder (bên trong body: với some View không phải là Viewbuilder)
        // trong này chỉ là function bình thường
        ZStack {
            // ở đây là 1 ViewBuilder
            let base = RoundedRectangle(cornerRadius: 12) // ViewBuilder chỉ có thể support cho 3 thứ
            // 1 - là if else || switch case
            // 2 - là list
            // 3 - là variable assignment -> gắn cho 1 biến 1 cụ thể như line 28
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }// Dùng Group ở đây vì để thay đổi opacity -> tránh việc khi dùng cardview ở lazyVGrdi (ở vGrid nó sẽ chỉ dùng space thấp nhất cần phải dùng. Sẽ group ở đây và thay đổi opacity thôi thì sẽ keep được chiều cao của cardview là cố định)
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            //            isFaceUp = !isFaceUp
            isFaceUp.toggle() //toggle thuộc extension của Boolen thôi nhá
        }
        .foregroundColor(.orange)
        .imageScale(.small)
    }
}

#Preview {
    ContentView()
}
