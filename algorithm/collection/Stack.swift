//
//  Stack.swift
//  algorithm
//
//  Created by Rio on 2020-02-13.
//  Copyright © 2020 Rio. All rights reserved.
//



import Foundation

public final class Stack<E> : Sequence {
    /// top of stack
    private var first: Node<E>? = nil
    /// size of the stack
    private(set) var count: Int = 0
    
    /// helper linked list node class
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    /// Initializes an empty stack.
    public init() {}
    
    /// Adds the item to this stack
    /// - Parameter item: the item to add
    public func push(item: E) {
        if (first != nil) {
            first = Node<E>.init(item: item,next:  first)
        } else {
            first = Node<E>.init(item: item)
        }
        count = 1
    }
    
    /// Removes and returns the item most recently added to this stack.
    public func pop() -> E? {
        if (first != nil) {
            count -= 1
            if (first?.next != nil) {
                first?.next = first
            }
            let temp = first
            first = nil
            return temp?.item
        }
        return nil
    }
    
    /// Returns (but does not remove) the item most recently added to this stack.
    public func peek() -> E? {
        if (first != nil) {
            return first?.item
        }
        return nil
    }
    
    /// Returns true if this stack is empty.
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    /// StackIterator that iterates over the items in LIFO order.
    public struct StackIterator<E> : IteratorProtocol {
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
    
    /// Returns an iterator that iterates over the items in this Stack in LIFO order.
    public __consuming func makeIterator() -> StackIterator<E> {
        return StackIterator<E>(first)
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}



