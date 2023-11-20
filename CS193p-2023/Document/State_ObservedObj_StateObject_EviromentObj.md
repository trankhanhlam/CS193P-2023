#  @State

@State thường được dùng trong struct. Dễ hiểu thì SwiftUI được base trên struct, các property trong struct là không thể thay đổi. Nếu mark với @State thì Swift sẽ hiểu là hãy giữ View (Struct đó) tồn tại trên memory, sau đó nếu property đó thay đổi thì khởi tạo (reload) lại struct (view) đó với thuộc tính đã thay đổi

# @ObservedObject

Được dùng cho 1 property gì đó phức tạp và có thể được dùng ở nhiều view khác nhau. 

Chú ý: Property nào mà được mark với @ObservedObject thì nó cần tuân thủ protocal ObservableObject.
Ngoài ra do đc dùng cho nhiều nơi khác nhau nên thường nên là class

# @StateObject

Đâu đó ở giữa @State và @ObservedObject là @StateObject

Sự khác biệt nằm ở việc View nào (Struct nào sẽ chịu việc giữ cho biến được mark với @ trên được tồn tại)

Với @StateObject - View nào tạo ra nó sẽ phải giữ cho nó tồn tại (nằm trên thuộc tính của nó)
Với @ObservedObject - Chỉ cần chú ý và xem xét tới biến đó (không phải là người tạo ra thuộc tính đó, và không có trách nhiệm để giữ nó tồn tại)

# @EnvironmentObject

Gần giống với @ObservedObject, là 1 dạng property wrapper được truyền từ view sang view. Thì chỉ cần với @EnvironmentObject nó sẽ là thuộc quyền của toàn app. Để cho bất kì view nào cũng được sờ tới.
(Đoạn này chưa clear lắm do chưa hiểu ý nghĩa thực sự)
