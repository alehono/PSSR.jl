function encode(tamanho, elemento) # Função que faz o encode dos aminoácidos e das classes
    a = zeros(Int64,tamanho)
    a[elemento] = 1
    return(a)
end

siglas = [ 'A', 'R', 'N', 'D', 'E', 'C', 'G', 'Q', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'Y', 'T', 'W', 'V', 'X' ]
codificadordeaminoacidos = Dict()

for (indice, elemento) in enumerate(siglas)
    codificadordeaminoacidos[elemento] = encode(length(siglas), indice)
end

const codificadordeSS8 = Dict(
    'H' => 'H',
    'G' => 'H',
    'I' => 'H',
    'P' => 'H',
    'E' => 'E',
    'B' => 'E',
    'C' => 'C',
    'T' => 'C',
    'S' => 'C',
    ' ' => 'C'
)

const codificadordeSS3 = Dict(
    'H' => [1,0,0],
    'E' => [0,1,0],
    'C' => [0,0,1]
)

function build_matrix_X(sequence::Vector{Char}, windowsize::Int)

    global codificadordeaminoacidos

    skip = Int64((windowsize-1)/2)
    X = Matrix{Int64}(undef, 21*windowsize, length(sequence)-2*skip) # que tenha tantas colunas quanto aminoácidos na sequência em questão, e tantas linhas quanto possíveis SS
    
    for i in 1:(length(sequence)-windowsize+1)

        fragment = sequence[i:i+windowsize-1]
        column = Vector{Int64}(undef, 21*windowsize)
    
        for aminoacid in 1:length(fragment)
            column[21*(aminoacid-1)+1:21*aminoacid] = codificadordeaminoacidos[fragment[aminoacid]]
        end
    
        X[:,i] = column
    
    end

    return(X)

end

function build_matrix_Y(structure::Vector{Char}, windowsize::Int)

    global codificadordeSS8
    global codificadordeSS3

    skip = Int64((windowsize-1)/2)
    Y = Matrix{Int64}(undef, 3, length(structure)-2*skip) # que tenha tantas colunas quanto aminoácidos na sequência em questão, e tantas linhas quanto possíveis SS
    
    structure_ss8 = [ codificadordeSS8[el] for el in structure ]

    for i in 1:(size(Y, 2)) # build matrix Y
        Y[:,i] = codificadordeSS3[structure_ss8[i+skip]]    
    end  # build matrix Y

    return(Y)
end

using ProgressMeter

function prepare_data(listofsequences::Vector{Vector{Char}}, listofstructures::Vector{Vector{Char}}, windowsize::Int, porcentagem_split=0.6)

    skip = Int64((windowsize-1)/2)

    numero_de_proteinas = length(listofsequences)
    indice_split = round(Int,numero_de_proteinas*porcentagem_split)
    sequencias_de_treino = listofsequences[1:indice_split]
    sequencias_de_teste = listofsequences[(indice_split+1):end]
    estruturas_de_treino = listofstructures[1:indice_split]
    estruturas_de_teste = listofstructures[(indice_split+1):end]

    X_train = Matrix{Int64}(undef, 21*windowsize, 0)
    X_test = copy(X_train)
    Y_train = Matrix{Int64}(undef, 3, 0)
    Y_test = copy(Y_train)

    @showprogress for (sequence, structure) in zip(sequencias_de_treino, estruturas_de_treino) # for sequence, structure in (train)
        if length(sequence) >= windowsize
            X_train = hcat(X_train, build_matrix_X(sequence, windowsize))
            Y_train = hcat(Y_train, build_matrix_Y(structure, windowsize))
        else
            continue
        end
    end # for sequence,structure in train
    println("Done building the Train Datasets")

    @showprogress for (sequence, structure) in zip(sequencias_de_teste, estruturas_de_teste) # for sequence, structure in (train)
        if length(sequence) >= windowsize
            X_test = hcat(X_test, build_matrix_X(sequence, windowsize))
            Y_test = hcat(Y_test, build_matrix_Y(structure, windowsize))
        else
            continue
        end
    end # for sequence,structure in train
    println("Done building the Test Datasets")
       
    return X_train, Y_train, X_test, Y_test
end