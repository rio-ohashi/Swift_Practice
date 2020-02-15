//
//  Stack.swift
//  algorithm
//
//  Created by Rio on 2020-02-13.
//  Copyright © 2020 Rio. All rights reserved.
//



import Foundation

public final class Bag<E>: Sequence {
    private var first: Node<E>? = nil
    private(set) var count: Int = 0
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public init() {}
    
    public func add(item: E) {
        if (first != nil) {
            var current = first
            while current != nil{
                if (current?.next != nil) {
                    current = current?.next
                } else {
                    current?.next = Node<E>.init(item: item)
                }
                count += 1
            }
        } else {
            first = Node<E>.init(item: item)
            count = 1
        }
    }
    
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public struct BagIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            current = first
        }
        
        public mutating func next() -> E? {
            guard let node = current  else { return nil }
            current = node.next
            return current?.item
        }
        
        public typealias Element = E
    }
    
    /// Returns an iterator that iterates over the items in this bag in reverse order.
    public __consuming func makeIterator() -> BagIterator<E> {
        return BagIterator<E>(first)
    }
}

