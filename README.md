# 起動方法
1. `docker-compose build` を実行
2. `docker-compose up` で起動
3. localhost:3000 にアクセス

# DB周りの操作
1. `docker-compose run --rm app rails db:create` でDB作成
2. `docker-compose run --rm app rails db:migrate` でテーブル作成