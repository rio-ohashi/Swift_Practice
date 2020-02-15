//
//  Stack.swift
//  algorithm
//
//  Created by Rio on 2020-02-13.
//  Copyright © 2020 Rio. All rights reserved.
//



import Foundation

public final class Queue<E> : Sequence {
    /// beginning of queue
    private var first: Node<E>? = nil
    /// end of queue
    private var last: Node<E>? = nil
    /// size of the queue
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
    
    /// Initializes an empty queue.
    public init() {}
    
    /// Returns true if this queue is empty.
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    /// Returns the item least recently added to this queue.
    public func peek() -> E? {
        return first?.item
    }
    
    /// Adds the item to this queue
    /// - Parameter item: the item to add
    public func enqueue(item: E) {
        if (last != nil) {
            var current = first
            while current != nil{
                if (current?.next != nil) {
                    current = current?.next
                } else {
                    current?.next = Node<E>.init(item: item)
                    last = current?.next
                }
                count += 1
            }
        } else {
            first = Node<E>.init(item: item)
            last = Node<E>.init(item: item)
            count = 1
        }
    }
    
    /// Removes and returns the item on this queue that was least recently added.
    public func dequeue() -> E? {
        if (first != nil) {
            let tempFirst = first
            var current = first
            first = nil
            while current != nil {
                if (current?.next == nil) {
                    last = current
                    break
                } else {
                    current = current?.next
                }
                count -= 1
            }
            if count == 1 {
                first = last
            }
            return tempFirst?.item
        }
        return nil
    }
    
    /// QueueIterator that iterates over the items in FIFO order.
    public struct QueueIterator<E> : IteratorProtocol {
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
    
    /// Returns an iterator that iterates over the items in this Queue in FIFO order.
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}
