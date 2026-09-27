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
	
	
	private func send(_ message: String) {
		guard let data = message.data(using: .utf8) else {
			return
		}
		
		connection?.send(
			content: data,
			completion: .contentProcessed { error in
				if let error {
					print("Send error : \(error)")
					return
				}
				print("Sent: \(message)")
				
				
			}
		)
		
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
				self.send("hello from client")
			default:
				print("Client State : \(state)")
			}
		}
		
		
		
		connection?.start(queue: .main)
	}
	
}
