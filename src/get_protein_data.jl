# Definindo o conjunto de dados:
function get_protein_data(path) # Função que lê os arquivos e transforma em vetores com os caracteres.
    
    file = open(path*"/lista-de-proteinas.txt", "r")
    protein_list = readlines(file)
    close(file)

    file = open(path*"/proteinas.fa", "r")
    fasta = readlines(file)
    close(file)

    Seq = Vector{Vector{Char}}(undef, length(protein_list)) # Lista de Resíduos
    Est = Vector{Vector{Char}}(undef, length(protein_list)) # Lista da Estrutura Secundária de Cada Resíduo

    println("Reading protein data files")
    @showprogress for i in 1:length(protein_list)
        # println("Lendo os dados relativos à proteína " * protein_list[i])
        # Arquivo fasta
        Seq[i] = collect(fasta[2*i])

        file = open(path * "/DSSP/" * protein_list[i] * ".dssp")
        dssp_file = readlines(file)[29:end]
        close(file)

        y = Vector{Char}(undef, length(dssp_file))
        for j in 1:length(y)
            y[j] = dssp_file[j][17]
        end
        Est[i] = y
        
    end
    println("End of the data reading")

    return Seq, Est
end