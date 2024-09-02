---
title: "基本は簡単！Apollo graphQLでサーバーを構築してみよう！"
date: "2022-10-06"
categories: 
  - "graphql"
coverImage: "サーバーを作ってみよう！.png"
---

こんにちは！

最近graphQLサーバーを作成する機会があったので、今回は簡単なgraphQLサーバーの構築についてまとめていきたいと思います。

## graphql サーバーの構築

データベースの内容をまとめて返すサーバーを構築していきます。

### 環境構築、パッケージのインストール

apollo-serverをインストールしていきます。

```
npm i apollo-server
```

#### 擬似データベースの作成

擬似的なDBを用意していきます。

実際の開発では、mongoDBやPostgreSQLなどのデータベースが使われます。

```
const fakeDatabase = [
  {
    id: 'id1',
    name: 'hirokei',
  },
  {
    id: 'id2',
    name: 'mickey',
  },
  {
    id: 'id3',
    name: 'minnie',
  },
];
```

### スキーマの定義

次に、サーバーで扱うデータの型を用意していきます。

実際の処理ではなく、ただの型であることに注意です。

今回の例では、Studentの型を用意し、データ取得用のクエリ型にgetStudentsをセットしています。

```
const {gql} = require('apollo-server');

const typeDefs = gql`
  type Query {
    getStudents: [Student]
  }
  type Student {
    id: String!
    name: String!
  }
`;
```

### リゾルバの定義

実際の処理の記述が必要なのはクエリのgetStories型なので、コールバック関数内にデータベースの内容を返すように記述します。

```
const resolvers = {
  Query: {
    getStudents: () => {
      return fakeDatabase;
    },
  },
};
```

### 用意したパーツでサーバー作成

用意した擬似DBとスキーマ、リゾルバを使ってサーバーを作成していきます。

```
const {gql, ApolloServer} = require('apollo-server');

const fakeDatabase = [
  {
    id: 'id1',
    name: 'hirokei',
  },
  {
    id: 'id2',
    name: 'mickey',
  },
  {
    id: 'id3',
    name: 'minnie',
  },
];

const typeDefs = gql`
  type Query {
    getStudents: [Student]
  }
  type Student {
    id: String!
    name: String!
  }
`;
const resolvers = {
  Query: {
    getStudents: () => {
      return fakeDatabase;
    },
  },
};
// サーバー作成
const server = new ApolloServer({ typeDefs, resolvers });
server.listen(5000, () => {
  console.log('server is running!');
});
```

### サーバーを起動、動作テスト

それでは、実際にサーバーを実行してみましょう。

```
node index.js
```

を実行し、サーバーを起動します。

http://localhost:5000へアクセスすると、apiテストが行えるので、実際にクエリを打ってみましょう！

```
query Query {
  getStudents {
    id
    name
  }
}
```

このクエリを実行すると、

```
{
  "data": {
    "getStudents": [
      {
        "id": "id1",
        "name": "hirokei"
      },
      {
        "id": "id2",
        "name": "mickey"
      },
      {
        "id": "id3",
        "name": "minnie"
      }
    ]
  }
}
```

データベースの内容が返されていることを確認してみましょう、お疲れ様でした！

## graphQLをちょっと深掘り

最近になってちょっとずつ聞くようになってきたgraphQL。

従来のREST APIと何が違い、どんな旨味があるのでしょうか？

### graphQLって何が良いの？

今更ですが、graphQLがどういったものなのかを再確認しておきましょう。

graphQLは、クライアントが欲しいと思ったデータのみを返すことができるクエリ言語です。

エンドポイントを一つに絞り、クエリの内容によって返すデータを変える方式なので、エンドポイントをいちいち探してコードを修正する必要がありません。

また、既存のREST APIをgraphQLサーバー化することもできるようです！

### graphQLにも色んな種類がある！

JSでgraphQLサーバーを実装する際、apollo graphqlだけでなく様々なツールがあるようです。

#### graphQL-js

[公式ドキュメント](https://graphql.org/graphql-js/)

#### grqphQL-yoga

[公式ドキュメント](https://github.com/dotansimha/graphql-yoga)
