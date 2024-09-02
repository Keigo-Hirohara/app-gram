---
title: "httpモジュールとexpressを使ったサーバー構築"
date: "2022-02-20"
coverImage: "サーバー-1.png"
---

勉強お疲れ様です！

アプリケーションフレームワークのExpress、Node.js標準モジュールのhttpを使ったサーバーを構築していきたいと思いますよ！

早速こちらです！

```
const http = require('http');
const express = require('express');

const PORT = 3000;

const app = express();

//expressとhttpでサーバーを生成
const server = http.createServer(app);

//ルーティング
app.get('/', (req, res) => {
    res.send('root url!');
});
server.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}!`);
});
```

ここで、一つ疑問に思うことがありました。

「expressだけでサーバーが作れるのに、どうしてhttpなんて使う必要があるんだ？」

### expressのみを使ったサーバーの場合

今まで学習してきたサーバーの初期コードはこんな感じでした。

```
const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    res.send('root url!');
});

app.listen(PORT, () => {
    console.log(`listening on port: ${PORT}`);
});
```

expressで作ったサーバーを直で使っていました。

こっちの方がコードが少なくて見やすいんじゃないですかね？？

```
express、httpの両方使った場合
const server = http.createServer(app);
server.listen(PORT, () => {
    console.log(`Listening on port: ${PORT}!`);
});

//----------------------
express単体を使った場合

app.listen(PORT, () => {
    console.log(`listening on port: ${PORT}`);
});

。。。単体の方が短くて良くね？？
```

しかし、httpモジュールを使ってサーバーを作る意味を知ったのです。。。

### httpモジュールを使う意味

では、どうしてわざわざhttpを使う必要があるのでしょうか。。。

それは、通信プロトコルを扱えるからなんです！

どういう事か説明しますね！

まず、webサイトのURLを見て見ましょう。

そうすると、http://〜〜.comといったようにhttpやhttpsといった文字の羅列から始まっているのはわかると思います。

このhttp。通信プロトコルと言われていて、通信の規格みたいなものなんです！

このhttpのおかげでインターネットからwebサイトを見ることができているのですが、時々違う通信規格を使う時があるのですよ。

一つ例を挙げるとwebScketと言われる通信プロトコルがあります。

双方向の通信を可能にするプロトコルなのですが、詳しくは説明しませんw

チャット機能や通話時に使われていて、URLはwss://〜〜から始まります。

![](images/サーバー-1024x576.png)

http通信に加え、websocket通信も実行する必要がある時、複数の通信プロトコルを扱う必要がありますよね！

そのときにhttpモジュールを使えば、複数の通信プロトコルを扱えるのです！

逆にexpressのみでサーバーを作ると、websocket通信に対応できないのです。。。

なので、今後はexpress,httpの両方を使ったサーバーを作っていきたいと思います(^^)

どうも、ありがとうございました！
