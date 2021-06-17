function classifier(x, y)

    X = Vector(undef, length(x))
    Y = similar(y)

    Siglas = Matrix(undef, 20, 2)
    Siglas[:,1] .= [ 'A', 'R', 'N', 'D', 'E', 'C', 'G', 'Q', 'H', 'I', 'L', 'K', 'M', 'F', 'P', 'S', 'Y', 'T', 'W', 'V' ]
    for i in 1:size(Siglas,1)
        Siglas[i,2] = Int64.(zeros(20))
        Siglas[i,2][i] = 1
    end

    for i in 1:length(y)
        if y[i] == 'G'
            y[i] = 'H'
        end
        if y[i] == 'I'
            y[i] = 'H'
        end
        if y[i] == 'E'
            y[i] = 'B'
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
    
    for i in 1:length(y)
        if y[i] == 'H'
            Y[i] = [1 0 0]
        end
        if y[i] == 'B'
            Y[i] = [0 1 0]
        end
        if y[i] == 'C'
            Y[i] = [0 0 1]
        end
    end

    for i in 1:size(Siglas, 1)
        f = getindex.(findall(j -> j == Siglas[i, 1], x))
        for index in f
            X[index] = Siglas[i, 2]
        end
    end

    return X, Y

end