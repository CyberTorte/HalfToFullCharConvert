# HalfToFullCharConvert
半角カナを変換するスクリプトです
<br>
現在ps1ファイルのみ実装しています

## 前提

PowerShellに最初からスクリプトファイルを読み込ませる
<br>
([ホームディレクトリのパス]\Documents\Microsoft.PowerShell_profile.ps1に記述する)
<br>
もしくは使うときにスクリプトファイルを読み込ませる
<br>
のどちらかをしてください。
<br>
ダウンロードするだけでは使用できません。

## 使用方法

``` PowerShell:使用方法
halfConv [ファイル名]
```

## 対応状況

現在ファイルへの入出力に対応しています。

今後対応予定は

- 文字列を受け取り標準出力に返す
- パイプに対応する
- 半角ハイフンに対応する

順次対応していきます。