# Definindo o conjunto de dados:
function get_protein_data(path) # Função que lê os arquivos e transforma em vetores com os caracteres.
    
    listfile = open(path*"/lista-de-proteinas.txt", "r")
    protein_list = readlines(listfile)
    close(listfile)

    #fastafile = open(path*"/proteinas.fa", "r")
    #fasta = readlines(fastafile)
    #close(file)

    Seq = Vector{Vector{Char}}(undef, 0) # Lista de Resíduos
    Str = Vector{Vector{Char}}(undef, 0) # Lista da Estrutura Secundária de Cada Resíduo

    println("Reading protein data files")
    @showprogress for i in 1:length(protein_list)

        # DSSP File
        dsspfile = open(path * "/DSSP/" * protein_list[i] * ".dssp")
        dssp_file = readlines(dsspfile)[29:end]
        close(dsspfile)
        
        # SEQUENCE
        x = Vector{Char}(undef, length(dssp_file))
        for j in 1:length(x)
            x[j] = dssp_file[j][14]
        end
        
        # STRUCTURE
        y = Vector{Char}(undef, length(dssp_file))
        for j in 1:length(y)
            y[j] = dssp_file[j][17]
        end
        
        bri = vcat(0, findall(f -> f == '!', x), length(x))
        for idx in 2:length(bri)
            x_vec = copy(x[bri[idx-1]+1:bri[idx]-1])
            y_vec = copy(y[bri[idx-1]+1:bri[idx]-1])
            Seq = vcat([x_vec], Seq)
            Str = vcat([y_vec], Str)
        end
    end
    println("End of the data reading")

    return Seq, Str
end
