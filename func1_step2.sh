cat 2839.dl.in cb.DL > in.dl
cat 2839.gblup.in cb.GBLUP > in.gblup
awk '{print $1}' in.dl  > col
sh $1.sh
cat col |while read id;do grep -w $id 1_$1.txt ;done > t1
grep -v x 2_$1.txt |awk '{print $2}' > t2
grep -v x 3_$1.txt |awk '{print $2}' > t3
grep -v x 4_$1.txt |awk '{print $2}' > t4
grep -v x 5_$1.txt |awk '{print $2}' > t5
grep -v x 6_$1.txt |awk '{print $2}' > t6
grep -v x 7_$1.txt |awk '{print $2}' > t7 
paste t1 t2 t3 t4 t5 t6 t7 |awk '{print $1,$2,$3,$4,$5,$7,$8}' |sed s/\\s/\\t/g |grep _ > all_$1.txt
rm t1 t2 t3 t4 t5 t6 t7 *R1
python select.py all_$1.txt 0.3
