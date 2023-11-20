#  1 vài thứ linh tinh bên cạnh

MVVM: Model-View-ViewModel

 # Model: 
 + Tách riêng độc lập hoàn toàn logic và data ra khỏi UI
 + Có thể là 1 struct đơn giản, cũng có thể là 1 SQL database, machine learning. hoặc nhiều thứ khác 

! Connect giữa UI và Model
 + Sẽ có 1 vài trường hợp khi mà model chỉ là State của UI (Case này sẽ không cần tạo "View Model")
 + Bth thì sẽ được kết nối qua class "View Model"
 + Sẽ cũng có 1 vài trường hợp khi mà UI connect trực tiếp vào Model và không thông qua "View Model"
 
 -> Bth nên chọn option 2 tạo ra ViewModel và connect qua đó

Model sẽ hole những thứ liên quan tới UI mà nó có thể đứng độc lập được (UI Independent).
Sau đó khi model change -> view sẽ thay đổi dựa trên model
view khi nhìn vào model sẽ chỉ là kiểu (read-only)

# Khi Model và View đã được connect qua ViewModel

Model có sự thay đổi (Model thường là struct và struct có 1 cách để thông báo có sự thay đổi)
Tại lúc này ViewModel sẽ là người thấy có sự thay đổi đó sau đó publishes sự thay đổi đó tới view
View lúc này sau khi nhận thấy có gì đó từ "ViewModel" thì sẽ update UI ( @ObseredObject, @Binding, .onRecive, @EnviromnetObject, .enviromentObject() )

# Vậy làm cách nào View có thể tác động ngược lại Model

View sẽ gọi tới Intent fucntion nằm trong ViewModel. (function dự tính, ý định)
ViewModel sẽ phải chứa list các action mà ng dùng có thể làm. Ví dụ: Khi người dùng tap vào 1 nút. Trên View sẽ gọi tới ViewModel. Function được gọi ở ViewModel không phải là "Nút A được ấn" mà là "Thực hiện hành động gì đó" (vì nút A ấn, sau này cũng có thể thay đổi là nút B ấn hoặc sự kiện gì đó xảy ra)

Sau đó ViewModel sẽ làm hành động cần thiết tương ứng để có thể tác động được vào Model.

Lúc này sẽ tạo ra 1 vòng tròn khi Model được connect ở bên trên. (Model thay đổi -> ViewModel nhận thấy -> ViewModel publishes thay đổi -> View nhận thay đổi -> View update UI)
