//
//  MulticastEventTransceiverTests.swift
//
//
//  Created by Князьков Илья on 30.04.2022.
//

import XCTest
import Combine
@testable import EventTransceiver

final class MulticastEventTransceiverTests: XCTestCase {

    let eventTransceiver = MulticastEventTransceiver<Int, Never>()
    var cancellableEventsContainer: Set<AnyCancellable> = []

    var firstPublisher: AnyPublisher<Int, Never> {
        eventTransceiver.publisher.eraseToAnyPublisher()
    }
    var secondPublisher: AnyPublisher<Int, Never> {
        eventTransceiver.publisher.eraseToAnyPublisher()
    }

    func testOnMulticastReceiveSubscription() {
        let value = 22
        let firstExpectation = expectation(description: "First publisher expectation")
        let secondExpectation = expectation(description: "Second publisher expectation")
        firstPublisher
            .sink { receivedValue in
                XCTAssertEqual(value, receivedValue)
                firstExpectation.fulfill()
            }
            .store(in: &cancellableEventsContainer)
        secondPublisher
            .sink { receivedValue in
                XCTAssertEqual(value, receivedValue)
                secondExpectation.fulfill()
            }
            .store(in: &cancellableEventsContainer)

        eventTransceiver.send(newValue: value)
        wait(for: [firstExpectation, secondExpectation], timeout: 0.3)
    }

}
