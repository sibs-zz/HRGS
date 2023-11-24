rm *snp *gblup *dl *SNP *pre t1 *dat *txt tmp.recode.vcf cb* order a.sh b.sh c.sh col
vcftools --vcf $1 --positions 5w_pos1 --recode --out tmp
head -1000 tmp.recode.vcf |grep QUAL|sed s/\\t/\\n/g |cat -n |awk '{if($1>=10)print }'> order
num=$(tail -1 order |awk '{print $1}')
for i in $(seq 10 $num);do echo "awk '{print \$0}' tmp.recode.vcf|grep -v \#|awk '{print \$1,\$2,\$4,\$5,\$$i}'|awk '{print \$1,\$2,\$3,\$4,substr(\$5,1,3)}'|sed s#\|##g |sed s#/##g |sed s/chr0//g|sed s/chr//g|sed s/\\\s/\\\t/g> ${i}.snp" ;done > a.sh

sh a.sh
awk '{print "mv "$1".snp "$2".snp"}' order  > rename.sh
sh rename.sh
ls *snp |while read id ;do echo awk -f compare.awk $id 5w_pos \|sed s/\\\\s/\\\\\t/g\> ${id}.SNP;done > b.sh && sh b.sh

sh combine.sh > c.sh && sh c.sh
ls *_*pre|while read id;do python dl_pre.py $id ${id}.dl;done 
ls *_*pre|while read id;do python gblup_pre.py $id ${id}.gblup;done 

ls *_*pre|sed s/.SNP//g > col

cp 2839.pheno 2839.pheno2
cat col| awk '{print $1,$1,"NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA","NA"}' >> 2839.pheno2

cat *_*gblup > t1
paste -d " " col t1 > cb.GBLUP

cat *_*dl > t1
paste -d " " col t1 > cb.DL
rm *snp *gblup *dl *SNP *pre t1

sed -i s/.snp//g cb.GBLUP 
sed -i s/.pre//g cb.GBLUP

sed -i s/.snp//g cb.DL
sed -i s/.pre//g cb.DL
