//: [Previous](@previous)

import Foundation

class Guild {
    var name: String
    unowned var owner: User?
    
    init(name: String) {
        self.name = name
        print("Guild init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var nickname: String
    // weak let -> ' weak' must be a mutable variable, because it may change at runtime
    // var와 옵셔널은 필수다 왜냐하면 weak는 레퍼런스 카운터가 0이 되면 자동으로 nil로 만들어버리기 때문이다.
    var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("User init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var nickname: User? = User(nickname: "Javier") // RC +1

var guild: Guild? = Guild(name: "SeSAC") // RC + 1


// 서로 참조
nickname?.guild = guild // RC + 1
guild?.owner = nickname // RC + 1

// weak
//nickname?.guild = nil // RC - 1
//guild?.owner = nil // RC - 1

nickname = nil // RC - 1
//guild = nil // RC - 1

guild?.owner
