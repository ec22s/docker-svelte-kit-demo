# docker-svelte-kit-demo

<a href="https://github.com/ec22s/docker-svelte-kit-demo/actions/workflows/test.yml"><img src="https://github.com/ec22s/docker-svelte-kit-demo/workflows/Build/badge.svg"></a>

- 2025年11月 最新のSvelteに付属のデモアプリをDockerコンテナにしたもの

- https://svelte.dev/docs/kit/creating-a-project に従い、プロンプトには下記の選択で作成したプロジェクトが元です

  - Which template would you like? : `SvelteKit demo`

  - Add type checking with TypeScript? : `Yes`

  - What would you like to add to your project? : `none`

  - Which package manager do you want to install dependencies with? : `npm`

- Dockerfileは https://github.com/asknotbad/docker-svelte-kit を参考にしました

- いまの仕事に役立つよう、そのままHerokuのContainer Stackへデプロイできるようにしました

  - デフォルトのソースを変更し `sveltejs/adapter-node` を使っています


<br>

- 動作確認環境

  - macOS 15.6 (24G84)

  - GNU bash, version 5.3.3(1)-release (x86_64-apple-darwin23.6.0)

  - Docker version 29.0.0, build 3d4129b9ea

  - Docker Compose version v2.40.3-desktop.1

<br>

- 使い方

  - コマンドは全て `Makefile` にあります

  - ローカル開発用

    - `make dev-up` コンテナイメージ作成 & 起動

      - Svelteを `npm run dev` で起動します

      - こちらはHerokuへのデプロイ対象外です

      - ホスト機から `http://localhost:5173` で開けます

    - `make dev-restart` コンテナ再起動

    - `make dev-down` コンテナを閉じイメージも消去

    - `make dev-clean-restart` コンテナを閉じイメージを再作成して起動

    - `make dev-in` 起動中のコンテナにログイン

    - `make dev-test` サーバにアクセス

  - デプロイ用

    - `make up` コンテナイメージ作成 & 起動

      - Svelteを `npm run build` でビルドし起動します

      - こちらはHerokuへデプロイできます

      - ホスト機から開けるポートマッピングは設定していません

    - `make restart` コンテナ再起動

    - `make down` コンテナを閉じイメージも消去

    - `make clean-restart` コンテナを閉じイメージを再作成して起動

    - `make in` 起動中のコンテナにログイン

    - `make test` サーバにアクセス

<br>

- Herokuへのデプロイコマンド (参考)

  - 本リポジトリのトップから実行します

  - あらかじめ `Heroku CLI` のインストールが必要です

  - 必要に応じ、対象のアプリ名を `-a ****` で指定して下さい

  - デプロイ

    ```
    heroku container:push web && heroku container:release web
    ```

  - Dynoをコマンドで起動するなら `heroku ps:scale web=1` など自由に

  - ここまでの作業で `https://Herokuアプリのドメイン/` で全世界に公開されます

  - その他のコマンド

    - ログを見る `heroku logs --tail`

    - Dynoを止める `heroku ps:scale web=0`

    - コンテナを消す `heroku container:rm web`
