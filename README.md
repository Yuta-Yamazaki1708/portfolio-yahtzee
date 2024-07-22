# 作品
### サイトURL
https://mysterious-lake-40470-e4ed147a9865.herokuapp.com/

# 開発した背景
任天堂switchで発売されている『世界のアソビ大全51』の中のゲームの一つ『ヨット』を自分でもプレイしたかったが、任天堂switchを持ってないので自分で作ってしまおうと思ったのが開発のきっかけです。

# アプリについて
サイコロを使ったヨットゲームを遊ぶことができます。結果をランキング形式で確認したり、他ユーザーの結果を閲覧したりできます。


# 使用技術
### フロントエンド
|使用技術|詳細|
|:--|:--|
|Turbo|javascriptフレームワーク|
|Stimulus|javascriptフレームワーク|
|Bootstrap|CSSフレームワーク|

### バックエンド
|使用技術|詳細|
|:--|:--|
|Ruby(3.2.2)|バックエンド言語|
|rails (7.0.8)|webアプリ開発フレームワーク|
|MySQL（8.0）|データベース|
|RSpec|各種テストの実行|
|Rubocop|コードスタイルのチェック|

### インフラ
|使用技術|詳細|
|:--|:--|
|S3|画像保存のためのストレージ|
|Docker/Docker-compose|仮想コンテナの設計、構築|
|CircleCI|CIプラットフォーム|
|heroku|Webアプリのデプロイ先|

# ER図
<img width="566" alt="スクリーンショット 2024-07-22 22 20 14" src="https://github.com/user-attachments/assets/c0f0daf0-97cc-4620-9c17-96695441f1a5">

# 機能紹介
### トップページ
新規登録、ログイン、ゲストログイン機能を使えます。ヘッダーメニューからルール、ランキングの確認ができます。
<img width="1402" alt="スクリーンショット 2024-07-22 22 37 37" src="https://github.com/user-attachments/assets/ea6a01ef-026e-489c-8614-f00c1ce4e0ac">

### ログインページ
deviseを利用したログイン機能です。ゲストログイン機能やGoogle-oauthを利用したGoogleアカウントでのログインも可能です。
<img width="1399" alt="スクリーンショット 2024-07-22 22 38 03" src="https://github.com/user-attachments/assets/b782a475-c377-4bd5-94ae-34fd641cd7f7">

### マイページ
プロフィール編集とkaminari（ページネーション機能のためのgem）を利用したゲーム結果の閲覧ができます。ゲーム結果は日付、得点で並び替えができます。
Turboを使用しているため、同一ページで編集、閲覧ができます。
<img width="1395" alt="スクリーンショット 2024-07-22 23 08 13" src="https://github.com/user-attachments/assets/2adc511a-7d47-4177-a8b5-5ac41fdfe87b">

### アカウントページ
deviseを利用したアカウント設定機能です。メールアドレスとパスワードの変更ができます。
<img width="1399" alt="スクリーンショット 2024-07-22 23 14 56" src="https://github.com/user-attachments/assets/52345651-8e36-40fc-b560-b9ab8a6be220">

### ゲームプレイページ
ヨットゲームをプレイできます。参加人数とサイコロを振る回数の設定ができます。
TurboとStimulusを使用しているため、同一ページでゲームプレイができます。
こちらからルールの確認ができます。
https://mysterious-lake-40470-e4ed147a9865.herokuapp.com/rules
<img width="698" alt="スクリーンショット 2024-07-22 22 53 37" src="https://github.com/user-attachments/assets/918b3fd1-a238-4e65-9a00-ce97a96d0115">

<img width="1401" alt="スクリーンショット 2024-07-22 22 56 20" src="https://github.com/user-attachments/assets/25c03aa3-e856-41d5-a46d-ea008f2a829e">

### ゲーム後の結果投稿
ゲーム結果をコメント付きで投稿できます。投稿はトップページで確認でき、他プレイヤーの投稿も確認できます。ユーザープロフィールやゲーム結果の詳細の確認もできます。
<img width="1400" alt="スクリーンショット 2024-07-22 22 41 14" src="https://github.com/user-attachments/assets/0787022c-9f29-4993-99b7-989a42b94d02">

<img width="1397" alt="スクリーンショット 2024-07-22 22 38 32" src="https://github.com/user-attachments/assets/e9bf6fb5-5132-4d0e-9033-a6a987fc066b">

### ランキングページ
総合ランキングと週間ランキングを確認できます。ユーザープロフィールやゲーム結果の詳細も確認できます。
<img width="1398" alt="スクリーンショット 2024-07-22 23 04 26" src="https://github.com/user-attachments/assets/36fdb454-1359-474d-ac33-5a6274f02b10">

# 機能一覧
|機能|説明、使用技術|
|:--|:--|
|ログイン機能|サインイン、サインアップ、ログアウト、退会機能（devise）|
|アカウント編集機能|アカウント情報、プロフィール編集機能（devise）|
|マイページ機能|プロフィール閲覧、編集、ゲーム結果の確認、ソートができます（kaminari,Turbo）|
|ゲーム機能|ヨットゲームのプレイができます。（Turbo,Stimulus）|
|ゲーム結果投稿機能|全ユーザのゲームの投稿、閲覧ができます。|
|ランキング機能|総合、週間ランキングが閲覧できます。|

# 今後の課題
railsのAction Mairerを使用し、メールアドレスの確認機能を実装する必要があります。
また、herokuへのデプロイはリージョンが日本にないので動作が遅くなりがちです。特にturboを使用したアプリはこのレイテンシの影響を大きく受けるので、デプロイ先をAWSに変更するのが今後の課題です。
