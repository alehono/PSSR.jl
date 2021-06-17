# Definindo o conjunto de dados:
function read() # Função que lê os arquivos e transforma em vetores com os caracteres.
    
    Seq = readlines(open("C:/Users/honoa/Machine Learning/Protein/1UBQ.fasta", "r"))[2] # Lista de Resíduos
    Est = readlines(open("C:/Users/honoa/Machine Learning/Protein/1ubq.dssp", "r"))[29:end] # Lista da Estrutura Secundária de Cada Resíduo

    x = Vector(undef, length(Seq))
    for j in 1:length(x)
        x[j] = Seq[j]
    end

    y = Vector(undef, length(x))
    for i in 1:length(y)
        y[i] = Est[i][17]
    end

    for k in 1:length(y)
        println(x[k], "  ", y[k])
    end
    
    return x, y
end