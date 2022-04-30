//
//  EventPublisher.swift
//
//
//  Created by Князьков Илья on 30.04.2022.
//

import Combine

public struct EventPublisher<AbstractTransceiver: EventTransceiverProtocol, Model, AbstractError>: Publisher
where AbstractTransceiver.Output == Model, AbstractTransceiver.AbstractError == AbstractError {

    // MARK: - Nested Types

    public typealias Output = Model
    public typealias Failure = AbstractError

    // MARK: - Pirvate Properties

    private weak var eventTransceiver: AbstractTransceiver?

    // MARK: - Initialization

    init(eventTransceiver: AbstractTransceiver) {
        self.eventTransceiver = eventTransceiver
    }

    // MARK: - Publisher

    public func receive<AbstractSubscriber: Subscriber>(subscriber: AbstractSubscriber)
    where EventPublisher.Failure == AbstractSubscriber.Failure, EventPublisher.Output == AbstractSubscriber.Input {
        let subscription = AnySubscription(eventTransceiver: eventTransceiver, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }

}
