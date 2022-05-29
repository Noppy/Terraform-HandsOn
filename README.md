# Terraform-HandsOn

# Terraform概要
## Terraformとは
[Introduction to Terraform](https://www.terraform.io/intro)
> HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share.

### Provider
Terrafomは、Terrafom本体と、Terrafomでデプロイするターゲットを操作するための`プロバイダー(PROVIDER)`で構成されます。
TerrafomでAWSソースを管理する場合は、AWSのプロバイダーをアドオンすることでAWSを管理することができます。
Provederは、Terraformのコードの中で宣言して、そのコードを`terrafom init`コマンドで初期化するときにネットから自動的にダウンロードされます。
![Terraform architecture](https://mktg-content-api-hashicorp.vercel.app/api/assets?product=terraform&version=refs%2Fheads%2Fstable-website&asset=website%2Fimg%2Fdocs%2Fintro-terraform-apis.png&width=2048&height=644)

## Terraformの種類
Terraformは、Terrafom CLI、Terrafom Cloud、Terraform Enterpriseの３種類の提供形態がある。
Terrafom Cloud、Terraform Enterpriseはバージョン管理&コラボ機能も含まれている(イメージとしては、GitHub + Terrafrom CLIがパッケージされている感じ)。

|  エディション| Terraform CLI    | Terraform Cloud | Terraform Enterprise |
| :------: | :--------------: | :-------------: | :------------------: |
|  提供形態 | Open Source(無償) | SaaS(５名まで無償) | Self Hosted(有償)    |
|  CLI機能 | あり          | あり              | あり                  |
| バージョン管理| -               | あり              | あり                 |
|コラボ機能   | -               | あり              | あり                 |

## 一般的な使い方
* Terraformコード管理
    * GitHub/gitLab/CodeCommitなど既存で利用しているコード管理ツールを一般的に利用する。
* Terrafom実行環境
    * PCにCLIをインストールして利用: 個人利用 / Terraform学習 / 検証の場合
    * サーバー(EC2インスタンス)にCLIをインストールして利用(*1)：　CI環境がない場合はこの構成が多い。OSログインし、gitからコードをpullしてコマンド操作する運用。
    * CIに組み込む(*1)。 [GitHub ActionsにCLIを組み込む(簡単おすすめ)](https://github.com/hashicorp/setup-terraform)、CodeBuildでTerraformを組み込んだコンテナを利用しCLを実装するなど。
(*1) 業務でTerrafomを利用する場合は、メタデータ(tfstate)のS3管理と、DybnamoDBbによる排他ロックを実装するのが鉄則

## ドキュメント
Terraformの情報はGoogleで検索するとブログやQiitaで多量に出ますが、2021/6にTerraformがGA(Terraform 1.0リリース)以前は仕様が頻繁に変わり互換性もない場合もあるため、最新バージョンで正しく動かないケースや現在は推奨しない設定方法を紹介している例が多々ある。
そのため、公式ドキュメントで仕様を確認するのが一番良い。
* 公式ドキュメント
    * [Terraform Documents](https://www.terraform.io/docs)
        * [Terraform CLI](https://www.terraform.io/cli) 
    * [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* 参考になる情報
    * [「それ、どこに出しても恥ずかしくないTerraformコードになってるか？」 / Terraform AWS Best Practices](https://speakerdeck.com/yuukiyo/terraform-aws-best-practices)
　　　　　　　　    ※ 前半部分がTerrafomを初めて使う人にわかりやすい。後半のモジュールは、一通りTerrafomが動かせるようになってから読むと良い。
# ハンズオン
## 事前準備
下記をあらかじめ準備しておくこと。
* Bashが使える環境(Linux on EC2、 Mac、Windows WSLなんでも可)
* デプロイ先のAWSアカウント
* 上記AWSアカウントをAdministratorAccess権限で操作可能なAWS CLIのプロファイル(TerraformがCLIを利用するわけではないですが、CLIのプロファイルを活用することができるため)

## Terraformセットアップ
こちらを参照
* [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

##
