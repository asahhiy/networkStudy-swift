//
//  ContentView.swift
//  networkStudy
//
//  Created by asahi aki on 2026/09/26.
//

import SwiftUI

struct ContentView: View {
	
	private let server = TCPServer()
	private let client = TCPClient()
	
	
	var body: some View {
		VStack {
			Button {
				server.start()
			} label: {
				HStack{
					Image(systemName: "server.rack")
				Text("サーバーを起動")
			
				}
				.padding(16)
				}
			.glassEffect()
			
			Spacer()
			Button{
				client.connect()
			} label: {
				HStack{
					Image(systemName: "figure.stand")
					Text("クライアントを起動")
				}
				.padding(16)
			}
			
			.glassEffect()
			.padding()
			
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
