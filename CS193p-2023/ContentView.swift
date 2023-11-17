//
//  ContentView.swift
//  CS193p-2023
//
//  Created by Tran Lam on 16/11/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈"]
    var body: some View {
        // Note: Không thể dùng for trong các Stack. Đọc bên dưới để biết trong ViewBuilder support những loại nào
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index], isFaceUp: true)
            }
        }
        .padding()
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
        ZStack {
            // ở đây là 1 ViewBuilder
            let base = RoundedRectangle(cornerRadius: 12) // ViewBuilder chỉ có thể support cho 3 thứ
            // 1 - là if else || switch case
            // 2 - là list
            // 3 - là variable assignment -> gắn cho 1 biến 1 cụ thể như line 28

            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill(.orange)
            }
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
