---
title: "webpackって何？TypeScriptの環境を構築してみよう！"
date: "2022-07-05"
coverImage: "Typescript.png"
---

## webpackって何？

webpackとは、複数のファイルを自分好みにまとめてくれるモジュール。

複数のJSファイルを一つのJSファイルにまとめてくれたり、CSSファイルやjpeg形式のファイルをそれぞれ一つのファイルにまとめてくれるらしいのだが、バンドル化の何が良いのかピンと来ません。

バンドル化によるメリットは結構あるようです！

1. 依存関係に気を遣って開発する必要がない（インポートの順番とか）
2. 使用しているライブラリ最適化してバンドル化してくれるので、処理が高速
3. 機能ごとにバンドルすることもできるので、整理整頓されたコードになり可読性が上がる

他にも、npmやyarnを使って外部モジュールをインストールできたり、読み込むファイルが少なくなることによる処理の高速化など嬉しい点が多いですね！

バンドル化するメリットは他にも色々あるのですが、下記の記事がすごい参考になりました

[https://masa-enjoy.com/webpack-usage#toc3](https://masa-enjoy.com/webpack-usage#toc3)

## webpack 環境構築手順

それでは、webpackを使ってTypescriptの環境を構築していきましょう！

### ディレクトリの作成、初期設定

まず、作成するプロジェクトのディレクトリを作成していきましょう！

```
$ mkdir ts-setup-demo
```

作成したディレクトリに移動し、パッケージ管理ツールを設定していきます

今回はyarnを使用していきますよ！（npmでも問題なくできます）

```
$ cd ts-setup-demo
$ yarn init -y
```

### 必要なパッケージのインストール

webpackを使ったTypescriptの環境構築に必要なパッケージをインストールしていきますよ！

typescriptとwebpack以外にもいくつか必要なパッケージが必要になってくるので、役割を軽くまとめておきます。

```
$ yarn add --dev typescript webpack ts-loader webpack-cli webpack-dev-server
```

#### ts-loader

Typescriptで構築したコードをwebpackでバンドル化するために必要なパッケージ

バンドル化する前にTypescriptで書いたコードをトランスパイルしてJavascriptに変換する必要があるのですが、ts-loaderで実現することができます！

#### webpack-cli

webpackを使用する上で必要なコマンド操作をできるようにするためのパッケージ

このパッケージがなければ、バンドル化に必要な操作を実行することができません。。。

#### webpack-dev-server

バンドル化したコードを実行するために必要なパッケージ

ローカルサーバーを立ち上げることができます！

### 構築に必要な情報を記述していく

#### tsconfig.jsonを作成

まず、TypescriptをJavascriptにトランスパイルするための準備をしていきます！

今回は、tsconfig.jsonのテンプレートを作成してみました！

ts.config.jsonファイルを手動で作成し、下記のコードをコピペしてみてください

```
{
  "compilerOptions": {

    "target": "es2016",
    // "module": "commonjs",
    "rootDir": "./src",
    "outDir": "./public/scripts",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,

    "strict": true,
    "skipLibCheck": true
  }
}
```

テンプレートの内容その他tsconfig.jsonの解説については、後日別記事でまとめたいと思います(^^)

#### webpack.config.jsを作成

次に、バンドル化に必要な設定を施していきます！

webpack.config.jsを手動で作成し、下記のコードを記述していきます

```
const path = require('path');
module.exports = {
  mode: 'development',
  entry: {
    index: './src/index.ts',
  },
  output: {
    path: path.join(__dirname, 'public/scripts'),
    filename: '[name].js',
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: 'ts-loader',
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'public'),
    },
  },
};
```

`webpack.config.js`についても、後日使い方をまとめようと思います！

### バンドル先のHTML, CSSを記述

次に、バンドル先で使用するHTMLとCSSを記述していきましょう！

webpack.config.jsで指定したバンドル設定に乗っ取ってHTML、CSSを記述していきますよ

#### /public/index.htmlを作成

webpack.config.jsでバンドル先をpublicディレクトリに指定しました（わからなくても大丈夫）

publicディレクトリを手動で作成し、以下のHTMLを記述していきます

名前はindex.htmlです！

```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="./styles/style.css" />
    <title>TS-demo</title>
  </head>
  <body>
    <h1>This is webpack demo using TS!</h1>
    <script src="./scripts/index.js"></script>
  </body>
</html>
```

#### /public/styles/style.cssを作成

次に、cssを記述していきましょう！

動作することを確認できればなんでも大丈夫ですよ(^^)

```
body {
  background-color: #EAF6F6;
}
```

### 処理を記述

それでは、実際にTypescriptのコードを記述していきましょう！

#### /src/index.tsを作成

まず最初に、/srcディレクトリを手動で作成しておきましょう

/src下にindex.tsを作成し、下記のコードを作成していきましょう！

```
import roadModule from './services/module';
console.log('Hello World!');
roadModule({ name: 'MacBook Air', price: 150000, description: 'Note PC' });
```

#### /src/services/module.tsを作成

次に、index.tsでインポートしたmodule.tsを作成していきます！

/src下にservicesディレクトリを作成、module.tsファイルを手動で作成しましょう

```
type product = {
  name: string;
  price: number;
  description: string;
};

export default function roadModule(product: product) {
  const showElement = document.getElementById('PR');

  const pName = document.createElement('h2');
  const pPrice = document.createElement('h2');
  const pDesc = document.createElement('h2');

  pName.innerText = product.name;
  pPrice.innerText = `${product.price}円`;
  pDesc.innerText = product.description;

  showElement?.appendChild(pName);
  showElement?.appendChild(pPrice);
  showElement?.appendChild(pDesc);
}
```

### トランスパイル、バンドル化してみる

それでは、記述したコードを実際に動かしていきましょう！

手順としては、以下の通りです

1. TSをJSにトランスパイルする
2. JSをバンドル化する

#### トランスパイル

まずはトランスパイルしていきます

```
$ tsc
```

上記のコマンドを実行すると、publicディレクトリにscriptsが追加されているはずです！

#### バンドル化

```
$ webpack --mode=development
```

webpack-dev-serverを使って、バンドル化をすることができます。

これで、バンドル化を完了できました！

### コードを実行してみる

それでは、バンドル化したコードを実行していきましょう！

htmlファイルをブラウザ上で実行してみると、追加したdom要素が追加されています

![](images/スクリーンショット-2022-07-05-22.45.22-1024x560.png)
