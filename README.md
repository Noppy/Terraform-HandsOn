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
- Terraformコード管理
      - GitHub/gitLab/CodeCommitなど既存で利用しているコード管理ツールを一般的に利用する。
- Terrafom実行環境
      - PCにTerraform　CLIをインストールして利用する: 個人利用 / Terraform学習 / 検証の場合
      - サーバー(EC2インスタンス)にインストールして利用する：　CI環境がない場合はこの構成が多い。OSログインし、gitからコードをpullしてコマンド操作する運用

## ドキュメント
- [Terraform Documents](https://www.terraform.io/docs)
- 
