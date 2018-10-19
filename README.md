# NEKODESU Project

どうも、猫です。

## セットアップ方法
セットアップを行うには以下の環境が必要なので準備してください。また、セットアップ方法はmacOSをベースに記述しております。
- Ruby v2.5.1
- Node.js(yarn)
- MySQL v5.7

このrepoをcloneして以下のコマンドを実行してください。
```
bundle install --path vendor/bundle
bundle exec rails db:create
bundle exec rails db:migrate
yarn install
```

## 環境実行方法
以下のコマンドを実行すれば動くようになるはず...!!
```
bundle exec foreman start -f Procfile.dev
```