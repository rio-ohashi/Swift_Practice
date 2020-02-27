//
//  File.swift
//  
//
//  Created by Rio on 2020-02-26.
//

import Foundation

class LCA {
    func start() {
        var g = Graph()
        let bfs = BFS(G: g!, s: 15)
        
        let numPairs = Int(readLine()!)!
        for _ in 0..<numPairs {
            let edge = readLine()!.components(separatedBy: " ").map { Int($0)! }
            let s = bfs.path(to: edge[0])
            while !(s?.isEmpty())! {
                var n = s?.pop()
                if edge[1] == n {
                    print(n)
                    break
                }
            }
            print(-1)
        }
    }
}
//
//Hello, world!
//16
//14
//1 2
//1 3
//2 4
//3 7
//6 2
//3 8
//4 9
//2 5
//5 11
//7 13
//10 4
//11 15
//12 5
//14 7
//6
//6 11
//10 9
//2 6
//7 6
//8 13
//8 15

//Optional(16 vertices, 14 edges
//0:
//1: 3 2
//2: 5 6 4 1
//3: 8 7 1
//4: 10 9 2
//5: 12 11 2
//6: 2
//7: 14 13 3
//8: 3
//9: 4
//10: 4
//11: 15 5
//12: 5
//13: 7
//14: 7
//15: 11
//)
