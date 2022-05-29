# tfstateファイルをS3格納する場合はこのファイルを設定する。
#　ここでは全てコメントアウトとしておく
# terraform {
#  backend "s3" {
#    bucket = "<tfstateファイルの格納先のバケット名>"
#    key    = "<tfstateファイルを格納するパス>"
#    region = "ap-northeast-1"
#  }
# }