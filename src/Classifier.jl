function encode(tamanho, elemento) # Função que faz o encode dos aminoácidos e das classes
    a = zeros(Int64,tamanho)
    a[elemento] = 1
    return(a)
end

function classifier(x, y, windowsize)
    
    skip = Int64((windowsize-1)/2)
    X = Matrix{Int64}(undef, 20*windowsize, length(x)-2*skip) # que tenha tantas colunas quanto aminoácidos na sequência em questão, e tantas linhas quanto possíveis SS
    Y = Matrix{Int64}(undef, 3, length(y)-2*skip) # que tenha tantas colunas quanto aminoácidos na sequência em questão, e tantas linhas quanto possíveis SS

    siglas = [ 'A', 'R', 'N', 'D', 'E', 'C', 'G', 'Q', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'Y', 'T', 'W', 'V' ]
    codificadordeaminoacidos = Dict()

    for (indice, elemento) in enumerate(siglas)
        codificadordeaminoacidos[elemento] = encode(length(siglas), indice)
    end

    for i in 1:length(y)
        if y[i] == 'G'
            y[i] = 'H'
        end
        if y[i] == 'I'
            y[i] = 'H'
        end
        if y[i] == 'B'
            y[i] = 'E'
        end
        if y[i] == 'T'
            y[i] = 'C'
        end
        if y[i] == 'S'
            y[i] = 'C'
        end
        if y[i] == ' '
            y[i] = 'C'
        end
    end

    for i in 1:(length(x)-windowsize+1)
        if y[i+skip] == 'H'
            Y[:,i] = [1, 0, 0]
        end
        if y[i+skip] == 'E'
            Y[:,i] = [0, 1, 0]
        end
        if y[i+skip] == 'C'
            Y[:,i] = [0, 0, 1]
        end
    end

    for i in 1:(length(x)-windowsize+1)

        fragment = x[i:i+windowsize-1]
    
        @show fragment
        column = Vector{Int64}(undef, 20*windowsize)
    
        for aminoacid in 1:length(fragment)
            column[20*(aminoacid-1)+1:20*aminoacid] = codificadordeaminoacidos[fragment[aminoacid]]
        end
    
        X[:,i] = column
    
    end
    
    return X, Y
end