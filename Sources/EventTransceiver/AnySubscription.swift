//
//  AnySubscription.swift
//
//
//  Created by Князьков Илья on 30.04.2022.
//

import Combine
import Foundation

final class AnySubscription<AbstractTransceiver: EventTransceiverProtocol, AbstractSubscriber: Subscriber, Model, AbstractError>: Subscription
where AbstractSubscriber.Input == Model,
      AbstractSubscriber.Failure == AbstractError,
      AbstractTransceiver.Output == Model,
      AbstractTransceiver.AbstractError == AbstractError {

    private weak var eventTransceiver: AbstractTransceiver?
    private var subscriber: AbstractSubscriber?

    init(eventTransceiver: AbstractTransceiver?, subscriber: AbstractSubscriber) {
        self.eventTransceiver = eventTransceiver
        self.subscriber = subscriber
        subscribeOnNewEvent()
    }

    // MARK: - Subscription

    func request(_ demand: Subscribers.Demand) { }

    func cancel() {
        subscriber = nil
    }

    // MARK: - Private Methods

    private func subscribeOnNewEvent() {
        eventTransceiver?.subscribe { [weak self] result in
            switch result {
            case .success(let model):
                _ = self?.subscriber?.receive(model)
            case .failure(let error):
                _ = self?.subscriber?.receive(completion: .failure(error))
            }
        }
    }

}
