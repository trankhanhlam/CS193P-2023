//
//  MemorizeGame.swift
//  CS193p-2023
//
//  Created by Tran Lam on 20/11/2023.
//

import Foundation

struct MemoryGame<CardContent> {

    private(set) var cards: Array<Card> // Set private ở đây vì không muốn bất cứ chỗ nào khác có thể thay đổi cards

    init(numberOfPairCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    } 

    func chosse(_ card: Card) {

    }

    // Tại soa cần mutating ở đây:
    /* Struct ở đây được khởi tạo với cards, struct là 1 immutable - Có nghĩa là khi khởi tạo với gì thì nó sẽ sống với thuộc tính đó.
     Ví dụ. Initwith ....
     Vì vậy cần mark function là mutating để cấp quyền cho phép function này có quyền để thay đổi thứ mà struct được khởi tạo nên cùng.
     Ở đây struct được khởi tạo với cards, self (MemoryGame) sẽ là immutable được khởi tạo với cards. Để thay đổi cards cần mark là function mutating. Note: Hàm shuffle sẽ thay đổi vị trí của các element trong chính mảng đó -> mảng thay đổi -> cần cấp phép để được thay đổi mảng
     */
    mutating func shuffle() {
        cards.shuffle()
    }

    struct Card {
        var isFaceUp = true
        var isMatch = false
        let content: CardContent
    }
}

