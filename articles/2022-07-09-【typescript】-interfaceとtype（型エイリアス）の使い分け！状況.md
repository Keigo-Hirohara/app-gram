---
title: "【TypeScript】 interfaceとtype（型エイリアス）の使い分け！状況に応じて適切な型を定義していこう！"
date: "2022-07-09"
coverImage: "型指定対決.png"
---

こんにちは！

今回はinterfaceとtype(型エイリアス)の違いと使い分けについて解説、紹介していきたいと思います。

## 基本事項、二つの相違

データの型を指定する際に使用されるinterfaceとtype。

２者にはどのような違いがあるのでしょうか？

### 記述方法

interface

```
interface product {
  name: string;
  price: number;
}
```

type

```
type product = {
  name: string;
  price: number;
}
```

\=がついているか否かの違いしかないことが分かると思います

結論、記述方法に大きな違いはありませんでした！

### 継承の可能 or 不可能

interface: 可能

type: 不可

interfaceは型の継承が可能ですが、typeはできません。

```
// interface

interface product {
  name: string;
  price: number;
}
継承可能なため、エラー発生せず
interface pc extends product {
  maker: string;
}


--------------------------------------


// type

type product = {
  name: string;
  price: number;
}
継承不可能なため、エラー発生 <'product' は型のみを参照しますが、ここで値として使用されています。>
type pc extends product = {
  maker: string;
}
```

### 継承元の拡張可能 or 不可能

interface: **不可**

type: 可能

新しく型指定を記述する際、typeは親から継承をすることで親にある既存の型を更新したtypeを作成することができます。

interfaceは<&>や<|>などの演算子を使って型指定をできないのが原因です。。。

一方、interfaceは親元の型更新が不可となっています。

```
// type

type product = {
  name: string;
  price: number;
}
// 値の更新が可能なため、エラー発生しない
type pc = product & {
  price: number | string;
}

--------------------------------------

// interface

interface product {
  name: string;
  price: number;
}
pcの型指定時点でエラー発生 <'product' は型のみを参照しますが、ここで値として使用されています。>
interface pc = product & {
  maker: string;
}
```

### 型の更新が可能 or 不可能（宣言のマージ）

type: 不可

interface: 可能

interfaceは同名の型があった場合、自動的に型を更新していきます

一方、typeは更新しようとするとエラーが発生してしまうのです

```
// interface

interface product {
  name: string;
  price: number;
}
// OK
interface product {
  maker: 'string';
  description; 'string';
}


-------------------------------
// type
type product = {
  name: string;
  price: number;
}
// 同名の型を指定できないため、エラー発生 <識別子 'product' が重複しています。>
type product = {
  maker: 'string';
  description: 'string';
}
```

## 使い分けるシチュエーション集

以上の相違点をもとに、どんな場合にはinterfaceを使うべきで、はたまたどんな場合にtypeを使えば良いのかを考えていきたいと思います。

実は使い分け、開発者の間でも結構な論争があるみたいですよ。。。！

基本的にはどちらを使っても問題はないと思います

相違点から出てくるメリットデメリットの捉え方次第で変わってくると思いますね

- 継承が可能なことをメリットと考えるならば、interface
- 型が勝手に更新されることで読みづらくなると考えるならば、interface
- 勝手に継承することでコードが読みづらくなることが懸念される場合は、type
- ユニオン型を使えることがメリットと考えるならば、type

開発中に迷ったら、開発ガイドラインに従うというのも手です。基本的にどちらを使って欲しい的な情報があるかと思われます。その情報に則っていけると良いですね(^^)
