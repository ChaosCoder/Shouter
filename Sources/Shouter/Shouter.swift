//
//  Shouter.swift
//  Shouter
//
//  Created by Andreas Ganske on 2019-01-09.
//  Copyright © 2019 Andreas Ganske. All rights reserved.
//

import Foundation

public protocol ShouterType {
    func register<T>(_ type: T.Type, observer: T)
    func unregister<T>(_ type: T.Type, observer: T)
    func unregister<T>(_ type: T.Type)
    func notify<T>(_ type: T.Type, block: (T) -> Void)
}

public class Shouter: ShouterType {
    
    public static let `default` = Shouter()
    
    fileprivate typealias Key = String
    fileprivate var observers: [Key: NSHashTable<AnyObject>] = [:]
    fileprivate let notificationQueue: DispatchQueue
    
    public init(notificationQueue: DispatchQueue = DispatchQueue(label: "de.chaosspace.Shouter.dispatch.queue", attributes: .concurrent)) {
        self.notificationQueue = notificationQueue
    }
    
    public func register<T>(_ type: T.Type, observer: T) {
        notificationQueue.sync(flags: .barrier) {
            let key = self.key(for: type)
            
            let set: NSHashTable<AnyObject>
            if let existingSet = self.observers[key] {
                set = existingSet
            } else {
                set = NSHashTable<AnyObject>.weakObjects()
                self.observers[key] = set
            }
            
            set.add(observer as AnyObject)
        }
    }
    
    public func unregister<T>(_ type: T.Type, observer: T) {
        notificationQueue.sync(flags: .barrier) {
            let key = self.key(for: type)
            guard let set = self.observers[key] else { return }
            set.remove(observer as AnyObject)
        }
    }
    
    public func unregister<T>(_ type: T.Type) {
        notificationQueue.sync(flags: .barrier) {
            let key = self.key(for: type)
            self.observers.removeValue(forKey: key)
        }
    }
    
    public func notify<T>(_ type: T.Type, block: (T) -> Void) {
        let key = self.key(for: type)
        guard let observers = self.observers[key] else { return }
        
        for observer in observers.allObjects {
            guard let observer = observer as? T else { continue }
            block(observer)
        }
    }
    
    private func key<T>(for type: T.Type) -> Key {
        return "\(type)"
    }
}
