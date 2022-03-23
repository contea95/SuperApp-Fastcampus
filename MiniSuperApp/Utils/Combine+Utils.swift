//
//  Combine+Utils.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/22.
//

import Combine
import CombineExt
import Foundation

// 커스텀 퍼블리셔
// 가장 최신값을 접근하지만 직접 Send는 할 수 없게,,

public class ReadOnlyCurrentValuePublisher<Element>: Publisher {
    
    public typealias Output = Element
    public typealias Failure = Never
    
    public var value: Element {
        currentValueRelay.value
    }
    
    fileprivate let currentValueRelay: CurrentValueRelay<Output>
    
    fileprivate init(_ initialValue: Element) {
        currentValueRelay = CurrentValueRelay(initialValue)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Element == S.Input {
        currentValueRelay.receive(subscriber: subscriber)
    }
}

public final class CurrentValuePublisher<Element>: ReadOnlyCurrentValuePublisher<Element> {
    typealias Output = Element
    typealias Failure = Never
    
    public override init(_ initalValue: Element) {
        super.init(initalValue)
    }
    
    public func send(_ value: Element) {
        currentValueRelay.accept(value)
    }
}

