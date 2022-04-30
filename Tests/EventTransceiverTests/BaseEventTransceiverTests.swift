//
//  BaseEventTransceiverTests.swift
//
//
//  Created by Князьков Илья on 30.04.2022.
//


import XCTest
import Combine
@testable import EventTransceiver

final class BaseEventTransceiverTests: XCTestCase {

    let eventTransceiver = BaseEventTransceiver<Int, Never>()
    var cancellableEventsContainer: Set<AnyCancellable> = []

    var eventPublisher: AnyPublisher<Int, Never> {
        eventTransceiver.publisher.eraseToAnyPublisher()
    }

    func testOnSuccessReceiveSubscription() {
        let value = 22
        let eventReceiveExpectation = expectation(description: "Publisher expectation")
        eventPublisher
            .sink { receivedValue in
                XCTAssertEqual(value, receivedValue)
                eventReceiveExpectation.fulfill()
            }
            .store(in: &cancellableEventsContainer)

        eventTransceiver.send(newValue: value)
        waitForExpectations(timeout: 0.3, handler: nil)
    }

}
