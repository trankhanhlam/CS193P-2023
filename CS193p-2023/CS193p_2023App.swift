//
//  CS193p_2023App.swift
//  CS193p-2023
//
//  Created by Tran Lam on 16/11/2023.
//

import SwiftUI

@main
struct CS193p_2023App: App {
    var body: some Scene {

        // Cần mark là StateObject vì như document @StateObject là cách để khởi tạo nên 1 observable object.
        /* Bên trong EmojiGameView cần truyền vào 1 Objected object - Nghĩa là 1 object có thể được nhìn thấy trông đợi, hóng sự thay đổi. Và khi tạo struct cần đủ các thông tin truyền vào để struct đầy đủ các thông tin để có thể khởi tạo. Do đó cần tạo ra 1 obserable object */
        @StateObject var game = EmojiMemoryGame()

        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
