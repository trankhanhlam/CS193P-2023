//
//  EmojiMemorizeGame.swift
//  CS193p-2023
//
//  Created by Tran Lam on 20/11/2023.
//

import SwiftUI
// Như ở file MVVM có ghi thì ViewModel cần được View quan sát để biết được có sự thay đổi từ Model -> cần kế thừa để biến ViewModel thành 1 class có thể quan sát được (ObservableObject)
class EmojiMemoryGame: ObservableObject {
    // Static ở đây mang ý nghĩa là biến bên dưới là global nhưng được đặt và bảo vệ dưới tên của struct này
    // Tại sao lại cần biến này là global
    /* Vì khi khởi tạo struct, các propert không phải được khởi tạo tuần tự mà là cầm cả cục lên để khởi tạo
     nên không biết được biến nào tạo được trước hay sau. Mà model khi khởi tạo cần sử dụng tới biến bên dưới để khởi tạo -> biến bên dưới cần chắc chắn được khởi tạo trước*/
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👺", "😱", "☠️", "🍭"]

    // lý do cần mark static cũng giống như ở bên trên, function cần phải có trước khi khởi tạo ra model
    // Ngoài ra cần set private vì ngoài ViewModel này ra ko chỗ nào được phép khởi tạo model nữa cả. Tránh việc động chạm gì đó tới model
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }

    // Set private để tránh View trup cập được vào model mà chỉ có viewmodel mới có quyền được thay đổi model
    // Tại đây mark Published để mark là thuộc tính này nếu có sự thay đổi gì đó thì thông báo lên cho những đối tượng nhìn vào viewmodel này biết
    /* Behind the scene: Sẽ có 1 objectWillChange nằm trong ObservableObject xử lý việc nếu có sự thay đổi thì bắn lên cho những Observer, việc xử lý đó đc xử lý đơn giản hơn với việc chỉ cần mark với @Published */
    @Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.chosse(card)
    }

}
