# README

## アプリ名
Yahtzee

## 開発した背景
任天堂switchで発売されている『世界のアソビ大全51』の中のゲームの一つ『ヨット』を自分でもプレイしたかったが、任天堂switchを持ってないので自分で作ってしまおうと思ったのが開発のきっかけです。

## 使用技術

### バックエンド言語
<img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=flat">

### バックエンドフレームワーク
<img src="https://img.shields.io/badge/-Ruby_on_Rails-D30001.svg?logo=Ruby_on_Rails&style=flat">

### フロントエンド言語
<img src="https://img.shields.io/badge/-HTML5-E34F26.svg?logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/-CSS3-1572B6.svg?logo=html5&logoColor=white">
<img src="https://img.shields.io/badge/-javascript-F7DF1E.svg?logo=javascript&logoColor=black&style=flat">

### フロントエンドフレームワーク
<img src="https://img.shields.io/badge/-Turbo-5CD8E5.svg?logo=turbo&style=flat">
<img src="https://img.shields.io/badge/-Stimulus-77E8B95.svg?logo=stimulus&style=flat">

### ミドルウェア
<img src="https://img.shields.io/badge/-MySQL-4479A1.svg?logo=mysql&logoColor=white">

### インフラ
<img src="https://img.shields.io/badge/-Docker-2496ED.svg?logo=docker&logoColor=white&style=flat">
<img src="https://img.shields.io/badge/-heroku-430098.svg?logo=heroku&style=flat">
<img src="https://img.shields.io/badge/-Amazon_S3-569A31.svg?logo=amazon_s3&logoColor=white&style=flat">

## ER図
[ER図](https://github.com/user-attachments/files/16093689/erd.pdf)

## アプリケーションについて
アプリケーションは、ログインして利用することができます。
ログイン方法は、アカウント新規登録、ゲストログイン、Googleアカウントログインがあります。
ログインせずとも利用できますが、ランキング登録、プロフィール編集、プロフィール閲覧機能が制限されます。

## Yahtzeeについて
Yahtzee(ヤツィー)とは
Yahtzee(ヤツィー)またはYacht(ヨット)とは、サイコロを使ったポーカーのようなゲームです。サイコロを振って役を作り、点数を競います。

ゲームの進め方
1.サイコロを振る
<img width="1030" alt="スクリーンショット 2024-02-12 14 11 47" src="https://github.com/Yuta-Yamazaki1708/portfolio-yahtzee/assets/131455394/d1c636f8-1418-4f98-85d3-c134f90c81a7">
サイコロを振るボタンをクリックするとサイコロを振ることができます。１ターンにサイコロを振れる最大回数は3回までです。

2.サイコロをキープする
<img width="1028" alt="スクリーンショット 2024-02-12 14 12 16" src="https://github.com/Yuta-Yamazaki1708/portfolio-yahtzee/assets/131455394/5503af5c-4f76-4c6c-ad8f-80684590edab">
振ったサイコロはキープすることができます。キープしたサイコロは次のサイコロを振るアクションでシャッフルせずに取っておくことができます。画像の例だと５、５はシャッフルせず、３、３、１のみシャッフルすることができます。

3.役を選択する
<img width="1000" alt="スクリーンショット 2024-02-12 14 12 53" src="https://github.com/Yuta-Yamazaki1708/portfolio-yahtzee/assets/131455394/af99fc48-11ee-40b3-9ee3-b2cd480e869b">
3回のシャッフルまでに役を揃えましょう。役が揃ったら選択し、点数を確定させます。なお、サイコロを3回振る前に役を選択することもできます。

役の説明
ワン
1の合計

ツー
2の合計

スリー
3の合計

フォー
4の合計

ファイブ
5の合計

シックス
6の合計

チョイス
全てのサイコロの合計

フォーダイス
同じ種類のサイコロが4つ以上の場合、全てのサイコロの合計

フルハウス
同じ種類のサイコロが3つと2つある場合、全てのサイコロの合計

S.ストレート
4つ以上のサイコロが階段状になっている場合、15点

B.ストレート
5つのサイコロが階段状になっている場合、30点

ヤツィー
同じ種類のサイコロが5つの場合、50点

## その他こだわりのポイント
