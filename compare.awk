# 处理第一个文件
FNR == NR {
    first_file[$1,$2] = $0
    next
}

# 处理第二个文件
{
    if (($1,$2) in first_file) {
        print first_file[$1,$2]
    } else {
        print $1"\t"$2"\t""NA""\t""NA""\t""00"
    }
}
