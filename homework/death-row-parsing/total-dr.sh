bash tx-dr.sh | sed 's/White/TX,White/' | sed 's/Hispanic/TX,Hispanic/' | sed 's/Black/TX,Black/'
bash fl-dr.sh | sed 's/BM/FL,Black/' | sed 's/BF/FL,Black/' | sed 's/WM/FL,White/' | sed 's/WF/FL,White/' | sed 's/HM/FL,Hispanic/' | sed 's/HF/FL,Hispanic/' | sed 's/OM/FL,Other/'
bash ca-dr.sh | sed 's/BLA/CA,Black/' | sed 's/WHI/CA,White/' | sed 's/HIS/CA,Hispanic/' | sed 's/OTH/CA,Other/'
