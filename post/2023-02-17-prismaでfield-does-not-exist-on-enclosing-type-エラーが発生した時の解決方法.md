---
title: "Prismaで\"Field does not exist on enclosing type\" エラーが発生した時の解決方法"
date: "2023-02-17"
categories: 
  - "docker"
  - "postgresql"
  - "prisma"
coverImage: "Prismaで-Field-does-not-exist-解決方法を紹介！-1.jpg"
---

こんにちは！ヒロケイと申します。

今回は、prismaを使ってサーバーの開発をしている時に遭遇した不可解なエラーを解決する方法について紹介します。

心当たりが無いのに、このようなエラーが発生すること、ありませんか？

エラー

```
Invalid `prisma.User.findUnique()` invocation:
Failed to validate the query: `Field does not exist on enclosing type. `
```

今回このエラーの解決方法を見つけたので、記録しておきます！

こんな人が読むと役立つ！

- ブランチを切り替えた途端、prismaのエラーが発生してしまった。。。

- コードに何も変更は加えていないが、データベースの接続がうまくできていない？

こういった悩みを解決するために役立ちます。

それでは見ていきましょう！

## 解決方法

![deno](images/名称未設定のデザイン-6.png)

deno

コードに何も変更は加えてないが、なぜかエラーが発生している。。。

こんな問題に遭遇した時は、大抵これらのコマンドで解決できます。

プロジェクトのディレクトリの最上層にて、このコマンドでnode\_modulesに保管されているprismaのキャッシュを検索します。

コマンド

```
find . -name .prisma
```

そして、検索して出てきたファイルを削除してprisma generateを実行します。

コマンド

```
rm -rf [findコマンドで検索したファイルの相対パス]/node_modules/.prisma
rm -rf [findコマンドで検索したファイルの相対パス]/node_modules/.cache
yarn prisma generate dev
```

これで解決できます！

## 解決できなかった時に見るべき場所

![](images/名称未設定のデザイン-32.jpg)

上記のコマンドを実行しても、解決できない時があります。

そんな時は、データベースとの接続がうまくできているかを確認しましょう！

確認事項リスト

- 開発環境のデータベースをDockerで動かしている場合は、ローカルのデータベースが実行されていないか確認

- Docker Desktopは起動しているか

- コンテナはしっかり走っている状態か

### ローカルのデータベースが切ってあるか

データベースにDockerを使っている場合は、デスクトップアプリでローカルデータベースを切っている必要があります。

確認してみましょう！

![](images/スクリーンショット_2023-02-17_8_57_23-1024x604.jpg)

### Docker Desktopが起動している、かつコンテナが走っていることを確認

データベースをDockerで動かしている場合は、起動しているかの確認をしましょう！

![](images/スクリーンショット_2023-02-17_9_06_25-1024x568.jpg)

## まとめ

今回の不可解なエラーは、想定外のPrismaのキャッシュが残ってしまっていたが故のエラーでした。

この類のエラーは、monorepoで開発している時に良く遭遇するエラーのようです。

最後まで読んでくださり、ありがとうございました。

当ブログでは、プログラミング未経験者が戦力となるエンジニアとして稼ぐまでに役立つ情報をお届けしています。

[

![](images/eda95f56404a9d453898b723f3d9107b.jpg)

参考

トップ

AppGram



](https://app-gram-kei.com/)
