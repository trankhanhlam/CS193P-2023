//
//  EmojiMemoryGameView.swift
//  CS193p-2023
//
//  Created by Tran Lam on 16/11/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    //ObservedObject có nghĩa là thuộc tính này cần được quan sát. Nếu có bất kì sự thông báo nào từ đối tượng này thì reloadUI, etc
    /*  */
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        // Note: Không thể dùng for trong các Stack. Đọc bên dưới để biết trong ViewBuilder support những loại nào
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffe") {
                viewModel.shuffle()
            }
        }

        .padding()
    }

    var cards: some View {
        // minimum size của grid item sẽ là 85
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(card: viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }

}

struct CardView: View {
    // Tại đây để let vì tất nhiên content của card chỉ được khởi tạo 1 lần và không cần thay đổi hay khởi tạo lại với cái khác
    let card: MemoryGame<String>.Card

    init(card: MemoryGame<String>.Card) {
        self.card = card
    }

    /*let isFaceUp: Bool = true*/ // Khi mark với @State là đang tạo ra biến này là 1 tham chiếu (pointer)
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
                Text(card.content)
//                    .font(.largeTitle)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    .aspectRatio(1, contentMode: .fit)
            }// Dùng Group ở đây vì để thay đổi opacity -> tránh việc khi dùng cardview ở lazyVGrdi (ở vGrid nó sẽ chỉ dùng space thấp nhất cần phải dùng. Sẽ group ở đây và thay đổi opacity thôi thì sẽ keep được chiều cao của cardview là cố định)
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .onTapGesture {

        }
        .foregroundColor(.orange)
        .imageScale(.small)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
