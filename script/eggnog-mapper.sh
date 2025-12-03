#!/usr/bin/env bash

input_dir="/bins"
output_base="/eggnog-mapper"
mkdir -p "$output_base"

log_file="${output_base}/eggnog-mapper.log"


for fa_file in "${input_dir}"/*.fa; do
    sample=$(basename "$fa_file" .fa)
    outdir="${output_base}/${sample}"
    mkdir -p "$outdir"


    if [[ -f "${outdir}/${sample}.emapper.annotations" ]]; then
        continue
    fi
   
   
    emapper.py \
        -i "$fa_file" \
        -m mmseqs \
        --itype genome \
        -o "$sample" \
        --output_dir "$outdir" \
        --cpu 32 \
        &>> "$log_file"

   
    echo "--------------------------------------" | tee -a "$log_file"
done

