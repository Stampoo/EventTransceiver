//
//  MulticastEventTransceiver.swift
//
//
//  Created by Князьков Илья on 30.04.2022.
//

open class MulticastEventTransceiver<Output, AbstractError: Error>: BaseEventTransceiver<Output, AbstractError> {

    // MARK: - Private Properties

    private var listeners: [(Result<Output, AbstractError>) -> Void] = []

    // MARK: - EventTransceiverProtocol

    override public func subscribe(_ subscription: @escaping (Result<Output, AbstractError>) -> Void) {
        self.listeners.append(subscription)
        tryNotifyListener()
    }

    override func tryNotifyListenerAboutNewValue() {
        guard let value = value else {
            return
        }
        listeners.forEach { listener in
            listener(.success(value))
        }
        self.value = nil
    }

    override func tryNotifyListenerAboutError() {
        guard let error = error else {
            return
        }
        listeners.forEach { listener in
            listener(.failure(error))
        }
        self.error = nil
    }

}
