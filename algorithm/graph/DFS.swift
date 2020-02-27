//
//  DepthFirstSearch.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/13/19.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

/// The `DFS` struct represents a data type for determining the vertices connected to a given source vertex in an undirected graph.
/// It also provides an API for finding paths from a source vertex `s` to every other vertex in an undirected graph.
/// - This implementation uses **depth-first search**
/// - The constructor takes **Θ(V+E)** time in the worst case, where `V` is the number of vertices and `E` is the number of edges.
/// - Each instance method takes **Θ(1)** time.
/// - It uses **Θ(V)** extra space (not including the graph) (Stack).
public struct DFS {
    /// marked[v] = is the vertex v visited? or is there an s-v path?
    private(set) var marked: [Bool]
    /// edgeTo[v] = last edge on s-v path
    private(set) var edgeTo: [Int]
    /// the number of vertices connected to the source s
    private(set) var count: Int = 0
    /// source vertex
    private let s: Int
    
    /// Computes the vertices in graph `G` that are connected to the source vertex `s`
    /// - Parameters:
    ///   - G: the graph
    ///   - s: the source vertex
    public init(G: Graph, s: Int) {
        self.s = s
        marked = [Bool](repeating: false, count: G.V)
        edgeTo = [Int](repeating: 0, count: G.V)
        try! validateVertex(s)
        dfs(G, v: s)
    }
    
    /// depth first search from v
    private mutating func dfs(_ G: Graph, v: Int) {
        marked[v] = true
        count += 1
        for u in G.adj(to: v) {
            if !marked[u] {
                edgeTo[u] = v
                dfs(G, v: u)
            }
        }
    }
    
    /// Is there a path between the source vertex `s` and vertex `v`?
    /// - Parameter v: the vertex
    /// - Returns: `true` if there's a path between the source vertex `s` and vertex `v`
    public func hasPath(to v: Int) -> Bool {
        try! validateVertex(v)
        return marked[v]
    }
    
    /// Returns a path between the source vertex `s` and vertex `v`, or `nil` if no such path.
    /// - Parameter v: the vertex
    /// - Returns: a path between the source vertex `s` and vertex `v`, or `nil` if no such path.
    public func path(to v: Int) -> Stack<Int>? {
        try! validateVertex(v)
        guard hasPath(to: v) else { return nil }
        let path = Stack<Int>()
        var current = v
        while current != s {
            path.push(item: current)
            current = edgeTo[current]
        }
        path.push(item: s)
        return path
    }
    
    private func validateVertex(_ v: Int) throws {
        let V = marked.count
        guard v >= 0 && v < V else {
            throw RuntimeError.illegalArgumentError("vertex \(v) is not between 0 and \(V-1)")
        }
    }
}
