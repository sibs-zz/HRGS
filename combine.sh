#!/bin/bash

# 获取当前目录中的所有文件列表
files=(*.SNP)

# 遍历文件列表，生成两两组合
for ((i=0; i<"${#files[@]}"; i++)); do
    for ((j=i+1; j<"${#files[@]}"; j++)); do
        file1="${files[i]}"
        file2="${files[j]}"
        echo "paste  $file1  $file2|awk '{if(\$5==\"00\" && \$10 ==\"00\"){print \$1,\$2,\$3,\$4,\"00\"}else if(\$5==\"11\" && \$10 ==\"11\"){print \$1,\$2,\$3,\$4,\"11\"} else if(\$5==\"00\" && \$10 ==\"11\"){print \$1,\$2,\$3,\$4,\"01\"} else if(\$5==\"11\" && \$10 ==\"00\"){print \$1,\$2,\$3,\$4,\"01\"} else {print \$1,\$2,\$3,\$4,\"..\"}}'|sed s/\\\\s/\\\\t/g > $file1"_"$file2.pre "
    done
done

