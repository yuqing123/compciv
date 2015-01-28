pdftotext data-hold/California_Condemned_Inmate_List.pdf -layout 
cat data-hold/California_Condemned_Inmate_List.txt| grep -oE 'Living.............' | grep -oE '\b[[:alpha:]]{3}\b'
