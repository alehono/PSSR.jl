# Definindo o conjunto de dados:
function read(path) # Função que lê os arquivos e transforma em vetores com os caracteres.
    
    protein_list = readlines(open(path*"/lista-de-proteinas.txt", "r"))
    fasta = readlines(open(path*"/proteinas.fa", "r"))

    Seq = Vector{Vector{Char}}(undef, length(protein_list)) # Lista de Resíduos
    Est = Vector{Vector{Char}}(undef, length(protein_list)) # Lista da Estrutura Secundária de Cada Resíduo

    for i in 1:length(protein_list)
        println("Lendo os dados relativos à proteína " * protein_list[i])
        # Arquivo fasta
        Seq[i] = collect(fasta[2*i])

        dssp_file = readlines(open(path * "/DSSP/" * protein_list[i] * ".dssp"))[29:end]
        y = Vector{Char}(undef, length(dssp_file))
        for j in 1:length(y)
            y[j] = dssp_file[j][17]
        end
        Est[i] = y

    end

    return Seq, Est
end