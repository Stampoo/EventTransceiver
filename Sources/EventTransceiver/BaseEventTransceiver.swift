//
//  BaseEventTransceiver.swift
//  
//
//  Created by Князьков Илья on 30.04.2022.
//

open class BaseEventTransceiver<Output, AbstractError: Error>: EventTransceiverProtocol {

    // MARK: - EventTransceiverProtocol

    typealias AbsctractPublisher = EventPublisher
    public typealias Output = Output
    public typealias AbstractError = AbstractError

    public var value: Output?
    public var error: AbstractError?
    public var publisher: EventPublisher<BaseEventTransceiver, Output, AbstractError> {
        EventPublisher(eventTransceiver: self)
    }

    // MARK: - Private Properties

    private var listener: ((Result<Output, AbstractError>) -> Void)?

    // MARK: - Initialization

    public init() { }

    // MARK: - EventTransceiverProtocol

    open func subscribe(_ subscription: @escaping (Result<Output, AbstractError>) -> Void) {
        self.listener = subscription
        tryNotifyListener()
    }

    public func send(newValue: Output) {
        self.value = newValue
        tryNotifyListener()
    }

    public func send(error: AbstractError) {
        self.error = error
        tryNotifyListener()
    }

    // MARK: - Internal Methods

    func tryNotifyListener() {
        tryNotifyListenerAboutNewValue()
        tryNotifyListenerAboutError()
    }

    func tryNotifyListenerAboutNewValue() {
        guard let value = value, let listener = listener else {
            return
        }
        listener(.success(value))
        self.value = nil
    }

    func tryNotifyListenerAboutError() {
        guard let error = error, let listener = listener else {
            return
        }
        listener(.failure(error))
        self.error = nil
    }

}
