pdftotext data-hold/California_Condemned_Inmate_List.pdf -layout 
cat data-hold/California_Condemned_Inmate_List.txt| grep -oE '\b(BLA|WHI|HIS|OTH)\b'
