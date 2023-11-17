//
//  SearchView.swift
//  SeSAC3SwiftUI
//
//  Created by 김규철 on 2023/11/16.
//

import SwiftUI

//struct SearchView: View {
//
//    @State var randomNumber = 0
//
//    init(randomNumber: Int = 0) {
//        self.randomNumber = randomNumber
//        print("SearchView")
//    }
//
//    var body: some View {
//        VStack {
//            HueView()
//            jackView
//            kokoView()
//            Text("부랜 \(randomNumber)")
//                .font(.largeTitle)
//                .background(Color.random())
//            Button("클릭") {
//                randomNumber = Int.random(in: 1...100)
//            }
//        }
//    }
//
//    var jackView: some View {
//        Text("jack")
//            .font(.largeTitle)
//            .background(Color.random())
//    }
//
//    func kokoView() -> some View {
//        Text("코종")
//            .font(.largeTitle)
//            .background(Color.random())
//    }
//}

struct Movie: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let color = Color.random()
    let count = Int.random(in: 1...100)
}

struct SearchView: View {
    
    @State private var searchQuery = "응가"
    @State private var showChart = false
    
//        let movie = ["ABC", "AB", "아이언맨", "부밤디부밤바"]
    
    private let movie = [
        Movie(name: "어벤저스"),  Movie(name: "골"),
        Movie(name: "aa"),  Movie(name: "bb"),
        Movie(name: "명량"),  Movie(name: "cc"),
        Movie(name: "어벤저스2"),  Movie(name: "레옹"),
        Movie(name: "인셉션"),  Movie(name: "어벤저스5")
    ]
    
    var filterMovie: [Movie] {
        return searchQuery.isEmpty ? movie : movie.filter {
            $0.name.contains(searchQuery)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filterMovie, id: \.self) { item in // keyPath를 name, color로 할 시 겹칠 수 있다.
                    //                    NavigationLink {
                    //                        SearchDetailview(movie: item)
                    //                    } label: {
                    //                        HStack {
                    //                            Circle()
                    //                                .foregroundColor(item.color)
                    //                            Text(item.name)
                    //                        }
                    //                        .frame(height: 60)
                    //                    }
                    
                    NavigationLink(value: item) {
                        HStack {
                            Circle()
                                .foregroundColor(item.color)
                            Text(item.name)
                        }
                        .frame(height: 60)
                    }
                }
            }
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
             ToolbarItemGroup(
                placement: .navigationBarTrailing) {
                    Button {
                        showChart = true
                    } label: {
                        Image(systemName: "star.fill")
                    }
                }

            }
            .navigationDestination(for: Movie.self) { item in
                SearchDetailview(movie: item)
            }
            
        }
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "검색검색")
        .onSubmit(of: .search) {
            print("검색")
        }
        .sheet(isPresented: $showChart) {
            ChartView(movie: movie)
        }
    }
}

struct SearchDetailview: View {
    
    let movie: Movie
    
    var body: some View {
        Text(movie.name)
    }
}


struct HueView: View {
    
    init() {
        print("HueView") // init은 @State 값이 변경될 때마다 계속 호출이 된다. SearchView에 하위뷰 인스턴스를 가지고 있기 때문이다.
    }
    
    var body: some View {
        Text("휴")
            .font(.largeTitle)
            .background(Color.random()) // body는 연산 프로퍼티이다. -> 메모리에 올라가지 않음
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}
