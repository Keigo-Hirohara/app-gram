---
title: '【開発環境構築】PostgreSQLをDockerで動かしてみよう！'
emoji: '😎'
type: 'tech' # tech: 技術記事 / idea: アイデア
topics: ['docker', 'postgresql', 'database', '開発環境構築']
published: true
---

こんにちは、今回は PostgreSQL の開発環境を Docker で構築する方法についてまとめていきたいと思います。

自分も Docker 初心者なので、参考程度に見ていってください。

## 事前準備

開発環境の構築前に確認することがあるので、見ていきましょう。

### ローカルの PostgreSQL をシャットダウンする

※既にローカル上に PostgreSQL をインストールしている方への内容です。

まずローカル上の PostgreSQL を止めていきましょう。

![](/images/screenshot-2022-10-28-9.21.17-1024x606.png)

上のように「**Running**」と表示されていると思います。

今 PostgreSQL が起動している状態なので、「**Stop**」ボタンを押してシャットダウンしていきましょう。

![](/images/screenshot-2022-10-28-9.19.08-1024x608.png)

上の画像のように、「**Not running**」と表示されていれば OK です！

なぜ PostgreSQL を切る必要があるのでしょうか？

それはローカル上で PostgreSQL が動いていると、Docker コンテナで起動している PostgreSQL と競合してサーバーやクライアントと接続できなくなってしまうからです。

接続がうまくいかない場合には再度シャットダウンされているか確認しましょう。

アプリを終了すると PostgreSQL が自動的に起動してしまうので、終了せず開いたままにしておいてくださいね。

### ファイル構成

```
.
├── README.md
├── .env
├── docker-compose.yml
└── postgresql
    └── init
        └─ init.sql
```

## 環境構築

それでは、実際に構築していきましょう。

### データベースの初期化コマンドを作成

まず、データベースを作成するコマンドを作成していきます。

/postgresql/init/init.sql に下記のコマンドを入力していきましょう。

```
CREATE USER <user_name>;

CREATE DATABASE <database_name>;

GRANT ALL PRIVILEGES ON DATABASE <database_name> TO <user_name>;　//ユーザーがDBの操作をできるように権限を付与

\c <database_name>
```

### 環境変数の設定

次に、データベースの作成に必要な認証情報を記述していきます。

.env ファイルに、下記の内容を記述してください

```
POSTGRES_USER=user
POSTGRES_PASSWORD=pass
```

### Docker コンテナの設定を記述

次に Docker のコンテナを走らせるための設定を記述していきます。

docker-compose.yml を記述していきましょう。

```
version: '3'
services:
  postgresql:
    container_name: postgresql
    image: postgres:14.0-alpine
    ports:
      - 5432:5432
    volumes:
      - ./postgresql/init:/docker-entrypoint-initdb.d
    environment:
      POSTGRES_USER: "${POSTGRES_USER}"
      POSTGRES_PASSWORD: "${POSTGRES_PASSWORD}"
    restart: always
```

これで、環境構築の準備が整いました！

### コンテナの起動

作成した docker-compose.yml から、コンテナを走らせていきましょう！

```
docker-compose up -d
```

## DB クライアントと接続

最後に、作成した PostgreSQL コンテナと DB クライアントを接続していきましょう。

クライアントツールは色々とありますが、今回は BDeaver を使っていきます。

https://dbeaver.io/

![](/images/screenshot-2022-10-28-10.54.11-1009x1024.png)

DBeaver にて、

Host: localhost

Port: 5432

Database: Dockerfile にて設定した database_name

ユーザー名: user

パスワード: pass

を入力することで、接続ができます。

## Docker を使うメリット

さて一連の構築手順が完了したわけですが、なぜわざわざ Docker を使う必要があるのでしょうか？

見ていきましょう。

### ローカルで PostgreSQL をインストールする必要がない

まず、 Docker は仮想環境を提供してくれるソフトウェアです。

0 からローカル上に環境を構築しようとなると、手間やコストがかかってしまいます。

一方、Docker はコンテナを走らせるコマンドを実行すれば、すぐに開発環境を用意することができます。

手間やコストを削減することができるので、積極的に使っていきたいですね(^^)

### 開発環境を統一できる

開発環境を簡単に構築できるというのもメリットですが、コンテナを用意することによって開発環境を統一できるというもの大きなメリットです。

チームで開発しようとなったとき

A さんは 既に環境構築が完了しているが、B さんはまだ言語のインストールさえできていない。

といった事態を防ぐことができるので、開発に集中することができます。

自分ももっと Docker を自由自在に扱えるように頑張っていきます(^^)
