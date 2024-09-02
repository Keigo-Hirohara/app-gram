---
title: "【Tailwind CSS】他要素の状態によってスタイリングを制御する方法"
date: "2022-11-16"
categories: 
  - "tailwind-css"
coverImage: "Tailwind.png"
---

## 解決前状態

緑の四角がホバーされた時、鉛筆マークの色を青色にしたい場合

![](images/スクリーンショット-2022-11-16-17.26.13.png)

```
<div className="relative flex items-center w-80 h-80 bg-green1 rounded-3xl ml-10 mb-10">
      <p className=" text-white text-xs mx-5 break-words line-clamp-4">
        testTask
      </p>
      <Edit2
        onClick={() => editTaskModalState()
        }
       // 親要素がホバーされた時、文字色を青色にしたい
        className="w-13 h-13 absolute bottom-5 right-5 text-white hover:text-blue1"
      />
    </div>
```

![](images/画面収録_2022-11-16_17_26_24_AdobeExpress.gif)

鉛筆マークにホバーした時のみ、スタイルが適用されてしまっています。

親要素がホバーされた時、鉛筆マークを青色にする必要がありますね。

その場合、どのようにホバーの監視対象を親要素に追加すれば良いのでしょうか？

## groupを使った解決方法

groupクラスを指定することで、親要素をホバーの監視対象に入れることができます。

```
// classNameにgroupを指定することで監視対象を親にも設定する
<div className="relative group flex items-center w-80 h-80 bg-green1 rounded-3xl ml-10 mb-10">
      <p className=" text-white text-xs mx-5 break-words line-clamp-4">
        testTask
      </p>
      <Edit2
        onClick={() =>　editTaskModalState()
        }
        // group-hoverとすることで、groupで監視されている要素がホバーされた際に発火
        className="w-13 h-13 absolute bottom-5 right-5 text-white invisible group-hover:visible"
      />
    </div>
```

![](images/画面収録_2022-11-16_17_36_25_AdobeExpress.gif)

親要素にgroupクラスを指定することで、親要素のホバー状態を鉛筆要素にも適用することができました。

ネストしたgroupなど、詳しくは[Tailwind CSS 公式ドキュメント](https://tailwindcss.com/docs/hover-focus-and-other-states)にて。
