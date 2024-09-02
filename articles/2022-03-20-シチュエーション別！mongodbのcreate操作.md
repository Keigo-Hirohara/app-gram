---
title: "シチュエーション別！mongodbのcreate操作"
date: "2022-03-20"
coverImage: "mongodb-create操作.png"
---

今回はmongoDBのCRUD操作のうち、C（Create）の部分についてシチュエーション別に処理を書いていきたいと思います！

（mongoDBの接続方法や環境のセットアップなど、前提知識については省略していますのでご了承ください）

## シチュエーション別！Create操作の例

３つのシチュエーション別に書いていきます！

```
const mongoose = require('mongoose');

const wordSchema = new mongoose.Schema({
    word: {
        type: String,
        required: true
    }
});

module.exports = mongoose.model('word', wordSchema);
```

先にmongooseにて、wordというモデルを作成しておきます。

### シンプルにドキュメントを作成

何の条件もなく、ただドキュメントを追加したい場合はinsertOneを駆使しましょう！

```
const createWord = async () => {
    await word.insertOne({
        word: '新単語'
    });
};
```

一番シンプルですね！

### 重複した内容がなければ、ドキュメントを追加。既存ならば更新。

追加したいドキュメントの内容が既にコレクションに存在していなければ、データを追加する場合を見ていきましょう！

この場合は、findOneAndUpdateを使用します！

```
const createWord = async () => {
  await word.findOneAndUpdate(
    {
      word: '新単語'　// wordの内容が既存でないかチェック
    }, {
        word: '新単語' // 追加するドキュメントの内容
    },
    {
      upsert: true, // 既存でない場合に新しく作成する設定
    }
  );
};
```

第１引数に既存かどうかを調べるフィルターを記述

第２引数に追加する内容を記述

第３引数に依存でない場合に追加をする設定

既存の場合、データが更新されてしまうことに注意です！

フィルターにかけたデータ以外に既存のドキュメントがデータを持っていた場合、そのデータが消滅してしまうので、注意が必要です！

データベースのドキュメントの中に複数のデータが格納されている場合は、あまりお勧めできません。（wordの他に詳細文や所有者のデータを付与されている場合）

### 重複した内容がなければ、ドキュメントを作成。既存ならば何もしない。

前回の処理は既存の内容があれば、ドキュメントが更新されてしまいます。

では、既存の場合に更新しない場合はどうすれば良いのでしょうか？

$setOnInsertを使用します！

```
const createWord = async () => {
    await word.findOneAndUpdate({
        word: '新単語',
    }, {
        $setOnInsert: {
            word: '新単語'
        }
    }, {
        upsert: true
    })
};
```

ドキュメントの中に複数のデータが格納されている場合に使用すると良いでしょう！
