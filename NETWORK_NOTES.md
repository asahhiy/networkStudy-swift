# Network.framework 概念ノート

学習時点の短い整理。実際の挙動や API の細部は、現在のコードと Apple の公式資料で確認し、観察前の推測を事実として書かない。

## TCP

- TCP は接続を伴う byte stream 型のトランスポート。
- アプリが送った文字列そのものではなく、符号化した byte 列が流れる。
- 送信一回と受信一回が一対一に対応する保証はない。メッセージ境界が必要になった段階で framing を設計する。

## `NWListener`

- 指定した設定・ポートで接続を待ち受ける側のオブジェクト。
- `stateUpdateHandler` は listener 自身の状態変化を観察する入口。
- `.ready` は待受を開始できる状態を表す。クライアントの接続・通信完了を意味しない。
- `newConnectionHandler` は新しい接続を受け取る入口。受け取った後の開始や保持方法をコードで確認する。

## `NWConnection`

- クライアントでは、通常、接続先 endpoint と TCP 等の parameters をもとに作る。
- サーバーでは listener が受け付けた接続を表す connection が渡される。
- `stateUpdateHandler` はその connection 自身の状態を観察する。
- `start(queue:)` は connection の処理を開始するために使う。listener の開始と connection の開始は別々のライフサイクル。
- `.ready` は通信処理を始められる状態を示すが、相手アプリが期待するメッセージを受け取ったことまでは意味しない。

## `Data` と文字列

- `String` を送るときは、たとえば UTF-8 を使って `Data` に符号化する。
- 受信した `Data` は、送信時と同じ文字コードで文字列へ復号する。
- 復号に失敗する可能性を考慮し、`String(data:encoding:)` の結果を確認する。
- `Data` は任意の byte 列を表せる。TCP 自体が Swift の `String` を扱うわけではない。

## 状態ハンドラーとキュー

- 状態ハンドラーは非同期イベントを受け取るクロージャ。設定した時点で状態が変わるのではなく、状態変化時に呼ばれる。
- `start(queue:)` に渡すキューはイベント処理の実行場所に関係する。UI 更新が必要な場合は適切なスレッド / キューへ戻す。
- まずログでイベント順を観察し、UI 状態管理の抽象化は必要になってから行う。

## SwiftUI Button

- `Button` の label 内の `Image(systemName:)` で SF Symbol を表示できる。
- label の中で `.padding()` を適用すると、表示上の余白とタップ領域に影響する。
- 学習アプリでは Button が listener / connection のどのライフサイクル操作を呼ぶのかを明確にする。
