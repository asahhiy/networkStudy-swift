# Network.framework 学習プロトタイプ

## 目的

Swift / iOS で Network.framework の TCP 通信を少しずつ実装し、各 API の役割と通信の流れを自分の言葉で説明できるようになる。Codex は完成コードを一括提供するのではなく、問いかけと小さな実験を通じて学習を支援する。

## 現在地

ユーザーからの引き継ぎ情報（2026-09-27）：

- TCP と `NWListener` / `NWConnection` を学習中。
- TCP サーバーを作成し、`NWListener.stateUpdateHandler` を設定して `ready` になるところまで確認した。
- TCP クライアントの構築に進み、接続先を持つ `NWConnection`、ローカル IP、connection 側の `stateUpdateHandler`、TCP が `Data` / byte ベースであること、文字列の encode / decode、`ready` 状態を確認した。
- 直近では SwiftUI の Button にアイコンと padding を追加できた。

上記は引き継ぎ時点の説明であり、具体的なソースファイル、変数名、実機・シミュレーター構成は未確認。次の Codex は作業環境を調べ、ユーザーに状況を確認してから続ける。

## 学習の進め方

1. 何を確かめる小さな変更なのか説明する。
2. 変更前にユーザーへ予想を尋ねる。
3. 必要最小限のコードだけを追加・変更する。
4. ユーザーが実行し、ログや画面から結果を観察する。
5. 予想と結果を比べ、ユーザー自身の詳細コメントで理解を整理する。

## 資料

- [AGENTS.md](AGENTS.md)：Codex の教師役としての行動ルール
- [ROADMAP.md](ROADMAP.md)：学習段階と将来の発展順
- [TASKS.md](TASKS.md)：直近の小さなタスクと完了条件
- [NETWORK_NOTES.md](NETWORK_NOTES.md)：主要概念の整理
- [DEBUGGING.md](DEBUGGING.md)：既知トラブルの切り分け

進捗や理解が変わったら、作業の区切りで該当資料を簡潔に更新する。推測を確定事項として記録しない。
