//
//  File.swift
//  networkStudy
//
//  Created by asahi aki on 2026/09/26.
//

import Foundation
import Network

final class TCPClient {
	private var connection : NWConnection?
	
	
	/// Sends a message encoded as UTF-8 over the current TCP connection.
	///
	/// If the message cannot be encoded as UTF-8, or if no connection is available,
	/// the method returns without sending. Any error reported after submission is
	/// printed to the console.
	///
	/// - Parameter message: The string to send.
	private func send(_ message: String) {
		guard let data = message.data(using: .utf8) else {
			return
		}
		
		connection?.send(
			content: data,
			contentContext: .finalMessage,
			isComplete: true,
			completion: .contentProcessed { error in
				if let error {
					print("Send error : \(error)")
					return
				}
				print("Sent: \(message)")
				
				
			}
		)
		
	}
	
	private func receiveReply() {
		connection?.receive(minimumIncompleteLength: 1, maximumLength: 1024) {data, context, isComplete, error in
		
			if let error {
				print("Reply receive error: \(error)")
			}
			
			if let data {
				let messege = String(data: data, encoding: .utf8)
			}
			
			if isComplete {
				print("Server finished sending")
			}
		
		}
	}
	
	
	func connect(){
		
		connection = NWConnection(
			host: "127.0.0.1",
			port: 5001,
			using: .tcp
		)
		
		connection?.stateUpdateHandler = {state in
			
			switch state {
			case .ready:
				print("Client connection is ready!")
				self.receiveReply()
				self.send("hello from client")
			default:
				print("Client State : \(state)")
			}
		}
		
		
		
		connection?.start(queue: .main)
	}
	
}
