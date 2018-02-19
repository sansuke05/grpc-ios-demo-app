# grpc-ios-demo-app
iOSアプリでgRPC通信を行うデモアプリ

## Usage

### 準備

リポジトリをクローン

`$ git clone https://github.com/sansuke05/grpc-ios-demo-app.git`

以下のprotobufを適当な言語にコンパイルし、サーバを用意して起動しておく

詳しくは公式の [クイックスタートガイド](https://grpc.io/docs/quickstart/) を参照

```HelloWorld.proto
syntax = "proto3";

option java_multiple_files = true;
option java_package = "com.hosopy.grpcdemo.helloworld";
option java_outer_classname = "HelloWorldProto";
option objc_class_prefix = "HLW";

package helloworld;

service Greeter {
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

message HelloRequest {
  string name = 1;
}

message HelloReply {
  string message = 1;
}
```

## 起動

Xcodeでプロジェクトを開く(※全てのファイルを開くために必ず`GrpcMobileDemo.xcworkspace`ファイルからXcodeを起動すること)

`$ open GrpcMobileDemo.xcworkspace`

XcodeのiOSシミュレータを選択し、プロジェクトをビルドして起動

アプリで文字を入力して、送信ボタンを押し、`Hello <送信した文字列>` がテキストビューに表示されたら成功
