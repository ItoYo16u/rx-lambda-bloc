2021/02 追記: Either, Option を使うにも外部ライブラリに依存しないといけないのであまり望ましくない。素直にDartのお気持ちに従ったほうがいい。

# functional_rx_bloc

functional reactive bloc pattern with rxdart,dartz and bloc.

## Getting Started

```shell script
git clone path/to/repository
cd path/to/dir
flutter pub get
```

## about
以下のような思想で設計している
- viewからコアロジックを分離する
- 初期化・認証・認可・ロギング・通知・課金などをコアロジックから分離する
- BLoCパターンを用い、テスタビリティを保つ
- Either,Optionを使い、エラーハンドリング・null安全を簡潔に表現する

また、StatelessWidgetとBLoCBuilder,ChangeNotifierを継承したViewModelを使い
画面の状態管理と画面構成を分離している

## viewについて
- <HOGE>App
  - ひとまとまりのMaterialApp
    - AuthApp
    - PrivateApp
※Entryは除く

- Screen
  - scaffoldを持つひとつの画面
- ScreenBuilder
  - BLoCの状態をListenし、その変更内容を画面に反映するためのウィジェット
- <HOGE>Form
  - ユーザーの入力を受け付けるウィジェット
  - viewModelを持つ
    - ドメインロジックと関係のない一般的なメールアドレス,電話番号などの規則のバリデーションと表示はここで行う
  - ``Provider.of<xxxBloc>(context).add(Event)``でイベントをBLoCに送信する
  
- helpers
  - viewで必要な定数・ルーティング・テーマデータなど
    - widget以下は非コアドメインの状態管理とviewへの反映をするためのウィジェット
- components
  - アプリを問わず再利用可能なウィジェット群
    - common
      - 最小単位
    - layout
      - 頻出するレイアウトを構成したり、レイアウトのネストを回避するためのウィジェット
### 想定されるドメインと関係の浅い機能要件
- 認証
  - AuthApp以下で対応
- テーマ設定などユーザーのローカルなpreferencesの復元
  - Entryで対応
- アップデートの通知と強制
- 初回起動・初回ログイン判定
