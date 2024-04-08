


import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private var user: User?
    
    private init() { }
    
    func login(userName: String, password: String, completion: @escaping(String) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if userName != "" && password != "" {
                self?.user = User(userName: userName, firstName: "Vijay", lastName: "reddy", email: "", age: 28)
                completion("Login success")
                
            } else {
                self?.user = nil
                completion("Invalid Credentials")
            }
        }
        
    }
    
    func getLoggedInUser() -> User? {
        return user
    }
}

