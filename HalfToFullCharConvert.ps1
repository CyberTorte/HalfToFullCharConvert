function global:halfConv ([string]$filename) {
    $path = $(Convert-Path .)
    $array = New-Object System.Collections.ArrayList

    # ファイル名と現在のパスを合わせる
    $file_name = $path + '/' + $filename
    # UTF-8(BOMなし)でファイル取得
    $file = New-Object System.IO.StreamReader($file_name, $false)

    # ファイルの要素を一旦配列に入れる
    while (($line = $file.ReadLine()) -ne $null)
    {
        [void]$array.add($line)
    }
    $file.Close()

    # 変換後文字列の全体格納用配列
    $after_array = New-Object System.Collections.ArrayList
    # 半角文字列のみ変換する
    foreach ($line in $array) {
            
        # カナ文字ストック用変数
        [string]$target = ""
        # 変換後文字列の1行分変数
        [string]$after_line = ""

        foreach ($char in $line.ToCharArray()) {
            # 半角の濁点、半濁点、半角ハイフン以外の記号は認めない
            # 半角カナを割り出す
            if ( $char -match '[\u002D\u30FC\u2010\u2011\u2013-\u2015\u2212\uFF70]' ) {
                $char = [Microsoft.VisualBasic.Strings]::StrConv($char, [Microsoft.VisualBasic.VbStrConv]::Wide)
                $target = $target + $char                
            }elseif ( $char -match '[\uFF66-\uFF6F\uFF71-\uFF9F]' ) {
                $target = $target + $char
            } elseif ( $target ) {
                # 半角カナを全角にする
                $target = [Microsoft.VisualBasic.Strings]::StrConv($target, [Microsoft.VisualBasic.VbStrConv]::Wide)
                $after_line = $after_line + $target + $char
                $target = ""
            } else {
                $after_line = $after_line + $char
            }
        }
        # 最後が半角カナ文字の場合を想定しての処理
        if ( $target ) {
            $target = [Microsoft.VisualBasic.Strings]::StrConv($target, [Microsoft.VisualBasic.VbStrConv]::Wide)
            $after_line = $after_line + $target
        }
        [void]$after_array.add($after_line)
    }
    
    # 追記しないようにClear-Contentコマンドレットでファイルを初期化
    clc $file_name

    # 書き込み用ストリームを展開
    $writer = New-Object System.IO.StreamWriter($file_name, $true, $utf8_not_BOM)

    # UTF-8(BOMなし)でファイルに書き込み
    foreach ($line in $after_array) {
        $writer.WriteLine($line)
    }
    $writer.Close()
}