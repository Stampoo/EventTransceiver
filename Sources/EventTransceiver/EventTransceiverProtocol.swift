//
//  EventTransceiverProtocol.swift
//
//
//  Created by Князьков Илья on 30.04.2022.
//

public protocol EventTransceiverProtocol: AnyObject {

    associatedtype Output
    associatedtype AbstractError: Error
    associatedtype AbsctractPublisher

    var value: Output? { get }
    var error: AbstractError? { get }
    var publisher: AbsctractPublisher { get }

    func subscribe(_ subscription: @escaping (Result<Output, AbstractError>) -> Void)
    func send(newValue: Output)
    func send(error: AbstractError)

}
