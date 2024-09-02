---
title: "どう使う？？jestでlocalStorageを使う方法"
date: "2022-03-26"
coverImage: "MOBAeスポーツ会場-プレゼンテーション-1.png"
---

MERNスタックでアプリを作っている際、ログイン機能の実装時にlocalStorageを使いました。

jwtの検証のためにloalStorageを使ったのですが、jestでテストコードを書いているとき、localStrageを使うために事前設定が必要だったので記録しておきます。

## コード

```

var localStorageMock = (function() {
    let store = {};
  
    return {
        getItem: function(key) {
            return store[key] || null;
        },
        setItem: function(key, value) {
            store[key] = String(value);
        },
        clear: function() {
            store = {};
        }
    };
  
  })();
  
  Object.defineProperty(window, 'localStorage', {
     value: localStorageMock
  });
```

上記のファイルを好きな場所に作成し、package.jsonにて、

```
"jest": {
    "setupFiles": [
      "./browserMocks.js"
    ],
    "testURL": "サーバーのURL"
  },
```

と記述してみてください！（browserMock.jsonのパスも自分の状況に合わせてみてください）

```
// データのセット
localStorage.setItem("<キー>", <値>);
// データの参照
localStorage.setItem("<キー>", <値>);
```
