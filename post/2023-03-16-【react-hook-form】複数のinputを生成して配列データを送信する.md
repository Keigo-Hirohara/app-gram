---
title: "【React Hook Form】複数のinputを生成して配列データを送信する方法"
date: "2023-03-16"
categories: 
  - "react"
coverImage: "Prismaで-Field-does-not-exist-解決方法を紹介！-4.jpg"
---

こんにちは、ヒロケイです。

今回は、入力欄を複数作成して配列データを送信する方法を紹介したいと思います。

使える状況

- 入力値だけでなく、入力データそのものを編集できるフォームを作りたい

- 材料や資材の種類や数量を編集する際、入力欄自体を追加して編集できるようにしたい

![deno](images/名称未設定のデザイン-6.png)

deno

送信値に配列を扱えるようになると、データが扱いやすくなるね！

React Hook Formの機能を使うことで、配列データを扱うこともできます。

サンプルコードをもとにして、実際に配列データを送信する様子を見てみましょう！

## useFieldArrayを使ってみよう

React hook Formで配列データを扱うためには、useFieldArrayというフックを使用することで実現可能です。

[

![](images/82ff54b2d44a758643127001430add97.png)

参考

useFieldArray



](https://react-hook-form.com/api/usefieldarray/)

### **サンプルコード**

以下のような複数のユーザーを追加するようなフォームを作成していきます。

![](images/gif.gif)

![](images/スクリーンショット-2023-03-16-10.24.39.jpg)

使用ライブラリ

- Chakra UI ([https://chakra-ui.com/](https://chakra-ui.com/))

- React Hook Form ([https://react-hook-form.com/](https://react-hook-form.com/))

```
// 親コンポーネント

const defaultValues = {
  usersData: [
    {
      name: 'Mickey',
    },
    {
      name: 'Minnie',
    },
    {
      name: 'Goofy',
    },
  ],
};

function App() {
  const methods = useForm();
  useEffect(() => {
    methods.reset(defaultValues);
  }, [methods]);

  return (
      <FormControl>
        <FormProvider {...methods}>
          <FormLabel>ユーザーネーム</FormLabel>
          <UserForm />
          <Box mt={6}>
            <Button
              colorScheme="blue"
              width="200px"
              type="submit"
              onClick={() => console.log(methods.getValues().usersData)}
            >
              送信
            </Button>
          </Box>
        </FormProvider>
      </FormControl>
  );
}

export default App;
```

methods.resetを実行してフォームのデフォルト値を設定しています。

コンポーネントを分割してフォームの作成をする場合は、親コンポーネントにて`FormProvider`要素を配置することをお忘れなく！

送信ボタンを押した際は、フォームの入力内容を出力するようにしています。

```
// 子コンポーネント
export const UserForm = () => {
  const { control, register } = useFormContext();
  const { fields, append, remove } = useFieldArray({
    control,
    name: 'usersData',
  });

  return (
    <div>
      {fields.map((item, index) => (
        <HStack mb={4} key={item.id}>
          <Box>
            <Input
              display="inline"
              // ネストした値を扱う際は、string値のなかに直接プロパティへのアクセス文を書く
              {...register(`usersData[${index}].name`)}
            ></Input>
          </Box>
          <Button display="inline" onClick={() => remove(index)}>
            削除
          </Button>
        </HStack>
      ))}
      <Button
        type="submit"
        onClick={() => {
          append({
            name: '',
          });
        }}
      >
        追加
      </Button>
    </div>
  );
};
```

ここでuseFieldValueを使って配列値を扱っていきます！

useFormContextフックで親コンポーネントのcontextオブジェクトにアクセスし、usefieldValueにcontrolを設定します。

また、nameに'usersData'を指定することで、contextオブジェクト内で扱う配列データを設定しています。

Inputタグにregisterを指定し、contextオブジェクト内で使用するデータを指定していきます。

そうすることで、デフォルト値や入力値を状態管理できるようになります。

## 細かいオプション、メソッド

```
  const { fields, append, remove, ...リターン値 } = useFieldArray({
    control,
    name: 'usersData',
    ...オプション
  });
```

useFieldArrayにはサンプルコードで使用したオプション以外にも様々な機能があります。

それらをざっと確認していきましょう。

### リターン値

リターン値では、配列の操作に関するさまざまな機能が格納されています。基本的な配列操作と変わらないものですね(^^)

- prepend: `(obj: object | object[]) => void`(先頭に追加)

- insert: ``(index: number, `obj: object | object[]`) => void``(特定の箇所に挿入)

- swap: `(from: number, to: number) => void`(既存の2つの要素を入れ替える)

- move: ``(`from: number, to: number`) => void``(既存の要素を指定の箇所へ移動)

- update: `(index: number, obj: object) => void`(既存のデータを更新する)

- replace: `(obj: object[]) => void`(配列自体を更新する)

### オプション

オプションでは、データを扱う時の細かい設定をすることができます。

- shouldUnregister: `boolean`(アンマウント後にcontextオブジェクトの参照を切るか否か。切った場合は初期値が削除される)

- rules: (データを送信する際のルールを記述できる。ルールの例については[公式Doc](https://react-hook-form.com/api/useform/register/)を参照)

## まとめ

いかがでしたでしょうか？

React Hook Formを使えば、いちいち入力値をstateで管理しなくても良くなりコードがシンプルになります。

ぜひ積極的に取り入れていきたいですね(^^)

こちらのブログは、ソフトウェアエンジニアを目指す大学生が勉強過程で得た知識をアウトプットする場として活用しています。ぜひご覧ください。

[

![](images/dd8aaf8e17a1394e434451426db54987.png)

参考

AppGram｜プログラミングスキルを習得して稼ぐ力を身につけよう

AppGram



](https://app-gram-kei.com/)
