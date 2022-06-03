rule get_strand:
    input:
        fq1 = lambda wildcards: get_fastq_files(wildcards)[0],
        fq2 = lambda wildcards: get_fastq_files(wildcards)[1],
    output:
        config["OUT_FILE"]+".txt"
    params:
        GTF = config["GTF"],
        KALLISTO_INDEX = config["KALLISTO_INDEX"],
        OUT_FILE = config["OUT_FILE"],
        RESULTS = config["RESULTS_PATH"]
    message:
        "--- Getting strandedness ---"
    shell:
        "mkdir -p {params.RESULTS} && "
        "cd {params.RESULTS} && "
        "check_strandedness --gtf {params.GTF} -k {params.KALLISTO_INDEX} --reads_1 {input.fq1} --reads_2 {input.fq2} > {params.OUT_FILE}.txt"