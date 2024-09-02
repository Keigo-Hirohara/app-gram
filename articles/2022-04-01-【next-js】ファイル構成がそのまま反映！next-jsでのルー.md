---
title: "【Next.js】ファイル構成がそのまま反映！Next.jsでのルーティング処理"
date: "2022-04-01"
coverImage: "Next.js-ルーティング.png"
---

Next.jsの学習が始まって間もないですが、少しずつ技術を磨いていきますよ(^^)

今回はNext.jsを使ったルーティング処理について学んだので、大事だと思った箇所をざっと復習していきます。

## Next.jsでのルーティング

今までReactでルーティング処理を記述してきました。

方法としては、エンドポイントの値によってどのコンポーネントを表示するかを設定するプログラムをApp.jsに記述していました。

```
const App = () => {
  return (
    <BrowserRouter>
      <Navigationbar />
      <Routes>
        <Route path="/register" exact element={<Register/>} />
        <Route path="/login" exact element={<Login/>} />
        <Route path="/idea" exact element={<Idea />} />
        <Route path="/idea/:id" exact element={<IdeaDetail />} />
        <Route path="/word" exact element={<Word />} />
      </Routes>
    </BrowserRouter>
  );
};
```

こんな処理を書いていたのですが、Next.jsではこの処理が不要になります。

なぜなら、ファイルの構成によってエンドポイントが決定されるからなんですよ！

例えば、こんなファイル構成があったとします。

```
pages
├── _app.js
├── courses
│   └── nextjs.js
├── index.js
```

シンプルにlocalhost:3000/をブラウズしたとき、index.jsの内容が表示されていきます。

ここでnextjs.jsのコンポーネントを表示したい場合を考えてみましょう。

nextjs.jsは、index.jsから/courses/nextjs.jsというパスで関係が成り立っています。

ファイル構成でルーティングできるので、URLにはlocalhost:3000/courses/nextjsと入力することでnextjsの内容が表示されるんですね！

ここで覚えておくべきことは。。。

- ファイルの構成によってルーティング処理が確立されていく
- ファイルの名前がそのままエンドポイントとなること

この二つですね！

### URLパラメータを含んだルーティングについて

では、エンドポイントにユーザーIDなどのURLパラメータが格納されたルーティング処理の実装はどうなるのでしょうか？

見ていきましょう！

```
.
├── _app.js
├── coffee-store
│   └── [id].js
├── index.js
```

答えは、\[\](鉤括弧)で囲うことで実装できます。

この例でいくと、localhost:3000/coffee-store/:id と言ったURLが設定されることになりますね！
