# このレポジトリについて
- https://github.com/being24/latex-template-ja を参考にしています.
  - devcontainerで環境を閉じています.
- INIADの学部生向けの卒業論文テンプレートです.
- LuaLaTeX + jlreq でビルドします. 完成イメージは [main.pdf](main.pdf) を参照してください.

# 使い方
## ツールの用意
### git
- gitの確認: `git --version`

### gh
- ghのインストール: `brew install gh`
- 認証: `gh auth login`

### Docker と VS Code
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) をインストールして起動しておく.
- [VS Code](https://code.visualstudio.com/) に拡張機能 [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) を入れる.

## レポジトリ作成
このレポジトリはテンプレートです. `gh repo create`で流用できます.
`gh repo create my_graduation_thesis --template="custard-1855/template_graduation_thesis" --private --clone`

## 環境の起動 (devcontainer)
1. VS Code で作成したレポジトリのフォルダを開く.
2. コマンドパレット (`Cmd/Ctrl + Shift + P`) から `Dev Containers: Reopen in Container` を実行する.
   - 初回はイメージ (`ghcr.io/being24/latex-docker`) のダウンロードに時間がかかります.
3. コンテナ内で以下のビルド・lintが使えます.

## ビルド
| コマンド | 内容 |
| --- | --- |
| `latexmk main.tex` (コンテナ内) | `main.pdf` を生成 |
| LaTeX Workshop の `Build LaTeX project` | 同上 (VS Code から) |
| `make` (ホスト側) | Docker経由で `main.pdf` を生成 |
| `make watch` | ファイル変更を監視して自動ビルド |
| `make clean` | 中間ファイルを削除 |

- ソースコード掲載に `minted` を使うため, `--shell-escape` を有効にしています (`.latexmkrc` 設定済み).
- TikZの図は `figures/` で単体ビルドしてPDFにしてから読み込みます (例: `cd figures && lualatex sample.tex`).

## 文章校正 (textlint)
| コマンド | 内容 |
| --- | --- |
| `npm install` (または `bin/install_textlint.sh`) | textlintのインストール (初回のみ) |
| `make lint` | `*/*.tex` をチェック |
| `make fix` | 自動修正できる指摘を修正 |

- 表記ゆれのルールは `prh.yml` に追加できます.

## 書き換える箇所
テンプレートから作成したら, 以下を自分の内容に書き換えてください. 各ファイルの `% ここを書き換える` が目印です.

| ファイル | 内容 |
| --- | --- |
| `main.tex` | タイトル・氏名・学籍番号・指導教員・日付, 章の構成 |
| `sections/00_abstract.tex` | 概要 (論文要旨) |
| `sections/01_introduction.tex` 〜 `05_discussion.tex` | 本文の各章 |
| `sections/appendix.tex`, `code/` | 付録・ソースコード |
| `references.bib` | 参考文献 |
| `figures/` | 図 (`sample.tex` / `sample.pdf` は削除してよい) |
| `main.pdf` | サンプルの完成例. 自分の論文をビルドすると上書きされます |

その他の主なファイル:
- `classes/INIAD_modern.cls`: 体裁 (表紙・見出し・余白など) の定義
- `bibliography.bbx`: 参考文献の表示スタイル
- `bin/diff.sh`: `latexdiff` で版ごとの差分PDFを作成
