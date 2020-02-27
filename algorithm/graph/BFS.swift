//
//  BreadthFirstSearch.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/13/19.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import Foundation

/// The `BFS` struct represents a data type for finding shortest paths (number of edges) from
/// a source vertex `s` (or a set of vertices) to every other vertex in an undirected graph.
/// - This implementation uses **breadth-first search**.
/// - The constructor takes **Θ(V + E)** time in the worst case, where `V` is the number of vertices
/// and `E` is the number of edges.
/// - Each instance method takes **Θ(1)** time.
/// - It uses **Θ(V)** extra space (not including the graph) (Queue).
public struct BFS {
    /// marked[v] = is the vertex v visited? or is there an s-v path?
    private(set) var marked: [Bool]
    /// edgeTo[v] = previous edge on shortest s-v path
    private(set) var edgeTo: [Int]
    /// distTo[v] = the number of edges shortest s-v paths
    private(set) var distTo: [Int]
    
    /// Computes the shortest path between the source vertex `s` and every other
    /// vertex in the graph `G`.
    /// - Parameters:
    ///   - G: the graph
    ///   - s: the source vertex
    public init(G: Graph, s: Int) {
        marked = [Bool](repeating: false, count: G.V)
        edgeTo = [Int](repeating: 0, count: G.V)
        distTo = [Int](repeating: Int.max, count: G.V)
        
        try! validateVertex(s)
        bfs(G, s)
        
        assert(check(G, s))
    }
    
    /// breadth-first search from a single source `s`
    private mutating func bfs(_ G: Graph, _ s: Int) {
        let q = Queue<Int>()
        distTo[s] = 0
        marked[s] = true
        q.enqueue(item: s)
        
        while !q.isEmpty() {
            let u = q.dequeue()! // because it's not empty
            for v in G.adj(to: u) {
                if !marked[v] {
                    marked[v] = true
                    edgeTo[v] = u
                    distTo[v] = distTo[u] + 1
                    q.enqueue(item: v)
                }
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
    
    /// Returns the number of edges in a shortest path between the source vertex `s`
    /// and vertex `v`
    /// - Parameter v: the vertex
    /// - Returns: the number of edges in a shortest path between the source vertex `s`
    public func dist(to v: Int) -> Int {
        try! validateVertex(v)
        return distTo[v]
    }
    
    
    /// Returns a shortest path between the source vertex `s` and `v`, or nil if no such path
    /// - Parameter v: the vertex
    /// - Returns: a shortest path between the source vertex `s` and `v`, or nil if no such path
    public func path(to v: Int) -> Stack<Int>? {
        try! validateVertex(v)
        guard hasPath(to: v) else { return nil }
        let path = Stack<Int>()
        var current = v
        while distTo[current] != 0 {
            path.push(item: current)
            current = edgeTo[current]
        }
        path.push(item: current)
        return path
    }
    
    /// check optimality conditions for single source
    private func check(_ G: Graph, _ s: Int) -> Bool {
        if distTo[s] != 0 {
            print("distance of source \(s) to itself = \(distTo[s])")
            return false
        }
        // check that for each edge u-v, dist[v] <= dist[u] + 1
        // provided u is reachable from s
        for u in 0..<G.V {
            for v in G.adj(to: u) {
                if hasPath(to: u) != hasPath(to: v) {
                    print("edge \(u)-\(v)")
                    print("hasPath(to: \(u) = \(hasPath(to: u))")
                    print("hasPath(to: \(v) = \(hasPath(to: v))")
                    return false
                }
                if hasPath(to: u) && distTo[v] > distTo[u] + 1 {
                    print("edge \(u)-\(v)")
                    print("distTo[\(u)] = \(distTo[u]))")
                    print("distTo[\(v)] = \(distTo[v]))")
                    return false
                }
            }
        }
        
        // check that u = edgeTo[v] satisfies distTo[v] = distTo[u] + 1
        // provided u is reachable from s
        for v in 0..<G.V {
            if !hasPath(to: v) || v == s { continue }
            let u = edgeTo[v]
            if distTo[v] != distTo[u] + 1 {
                print("shortest path edge \(u)-\(v)")
                print("distTo[\(u)] = \(distTo[u]))")
                print("distTo[\(v)] = \(distTo[v]))")
                return false
            }
        }
        return true
    }
    
    private func validateVertex(_ v: Int) throws {
        let V = marked.count
        guard v >= 0 && v < V else {
            throw RuntimeError.illegalArgumentError("vertex \(v) is not between 0 and \(V-1)")
        }
    }
}
