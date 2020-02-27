//
//  Graph.swift
//  SwiftAlgorithmsDataStructures
//
//  Created by Derrick Park on 2/12/19.
//  Copyright © 2020 Derrick Park. All rights reserved.
//
import Foundation
/// The *Graph* class represents an undirected graph of vertices named 0 through **V** - 1
/// It supports the following two primary operations: add an edge to the graph,
/// iterate over all of the vertices adjacent to a vertex. It also provides methods for returning
/// the degree of a vertex, the number of vertices **V** in the graph, and the number of edges **E** in the graph.
/// - Parallel edges and self-loops are permitted.
/// - By convention, a self-loop **v**-**v** appears in the adjacency list of **v** twice and contributes two to the degree of **v**.
/// - This implementation uses an adjacency-lists representation, which is a vertex-indexed array of
/// **Bag** objects.
/// - It uses **Θ(E + V)** space, where *E* is the number of edges and **V** is the number of vertices.
/// - All instance methods take **Θ(1)** time. (Though, iterating over the vertices returned by `adj(int)` takes time proportional to the degree of the vertex.)
/// - Constructing an empty graph with **V** vertices takes **Θ(V)** time; constructing a graph with **E** edges and __V__ vertices takes **Θ(E + V)** time.
public final class Graph {
    /// number of vertices
    let V: Int
    /// number of edges
    private(set) var E: Int
    /// adjacency list
    private var adj: [Bag<Int>]
    
    /// Initializes an empty graph with `V` vertices and 0 edges.
    /// failable initializer
    /// - Parameter V: the number of vertices
    public init?(V: Int) {
        guard V >= 0 else { return nil }
        self.V = V
        self.E = 0
        self.adj = [Bag<Int>]()
        self.adj.reserveCapacity(V)
        for _ in 0..<V {
            self.adj.append(Bag<Int>())
        }
    }
    
    /// Adds the undirected edge u-v to this graph.
    /// - Parameters:
    ///   - u: one vertex in the edge
    ///   - v: the other vertex in the edge
    public func addEdge(from u: Int, to v: Int) {
        try! validateVertex(u)
        try! validateVertex(v)
        E += 1
        adj[u].add(item: v)
        adj[v].add(item: u)
    }
    
    /// Returns the degree of vertex `v`
    /// - Parameter v: the vertex
    /// - Returns: the degree of vertex `v`
    public func degree(of v: Int) -> Int {
        try! validateVertex(v)
        return adj[v].count
    }
    
    /// Returns the vertices adjacent to vertex `v`
    /// - Parameter v: the vertex
    /// - Returns: the vertices adjacent to vertex `v`
    public func adj(to v: Int) -> Bag<Int> {
        try! validateVertex(v)
        return adj[v]
    }
    
    private func validateVertex(_ v: Int) throws {
        guard v >= 0 && v < V else {
            throw RuntimeError.illegalArgumentError("vertex \(v) is not between 0 and \(V-1)")
        }
    }
}

extension Graph: CustomStringConvertible {
    public var description: String {
        var s = "\(V) vertices, \(E) edges\n"
        for (v, bag) in adj.enumerated() {
            s += "\(v): \(bag)\n"
        }
        return s
    }
}
extension Graph {
    /// Initializing a graph from standard input
    convenience init?() {
        let V = Int(readLine()!)!
        let E = readLine().flatMap(Int.init)!
        self.init(V: V)!
        for _ in 0..<E {
            let edge = readLine()!.components(separatedBy: " ").map { Int($0)! }
            self.addEdge(from: edge[0], to: edge[1])
        }
    }
}
