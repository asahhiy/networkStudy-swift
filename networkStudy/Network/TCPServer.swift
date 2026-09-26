//
//  File.swift
//  networkStudy
//
//  Created by asahi aki on 2026/09/26.
//

import Foundation
import Network


final class TCPServer {
	private var listener: NWListener?
	
	//ここをprivateにしているのはこのクラス自身の内部処理で使うlib的な関数だからprivateにして外部から呼び出すことを禁止している。
	private func receive(on connection: NWConnection) {
		connection.receive(
			minimumIncompleteLength: 1, //簡単に言ったら1バイトでもデータが届いたら受信結果を返してもよいってこと
			maximumLength: 1024 //maxmumは一回の通信で何倍とまで受け取るかを指定。
		) {data, context, isComplete, error in
			//もちろん通信なのでdataが存在する保証がないため存在する時のみに実行するように if let 構文を使用している
			if let data,
			   let message = String(data: data, encoding: .utf8) {
				print("Recieved Message: \(message)")
			}
			
			//もしここで処理を止めてしまったら次からの通信を受け取ることができなくなってしまう。
			//なぜならTCPは受け取ったら次の通信に備えてまたreceiveを起動しないとダメだから。そのため、再帰的な処理を下に記述していく。
		
			//次のデータを待つ
			self.receive(on: connection)
		}
	}
	
	func start() {
		do {
			//ここではポート5000で通信を行うオブジェクトを生成しただけ
			listener = try NWListener(
				using: .tcp,
				on: 5000
			)
			
			//イベント駆動型のものでは先にして欲しい挙動を先に記述しておいて準備ができてからサーバを起動する方が設計上良い。
			//受付開始してから受け取った時のイベントを定義していると、その間の時間にきたリクエストの処理を考えることになるから。
			//このnewConnectionHandlerは新しく接続してきたときに何をするかを定義する。今回は接続成功したことをprintで表示しているだけ。
			listener?.newConnectionHandler = { connection in
				//この書き方はクロージャという書き方。newConnectionHandlerはそもそもNWConnectionという型を持っている。->voidみたいな仕様になっている(Xcodeの定義ジャンプ参照)
				//抽象化すると引数としてそのNWConnectionを持っているからこの書き方をすると後のvoidの関数を書くことができる。
				print("New connection: \(connection)")
				
				
			//通信の状態を表示するアップデートハンドラ
				connection.stateUpdateHandler = { state in
					switch state {
					case .ready:
						print("Connection is ready!")
						self.receive(on: connection)
					default:
						print("Connection state : \(state)")
					}
					
				}
				
				//受け取ったconnectionで通信スタート
				connection.start(queue: .main)
			}
			
			//リスナーをとりあえずメインスレッドのキューで処理するで指定する
			listener?.start(queue: .main)
		} catch {
			print("fail to create listener error:\(error)")
		}
	}
}
