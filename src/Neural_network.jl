function onecoldencoding(M::Matrix)
    n = size(M,2)
    onecold = zeros(n)
    for sample in 1:n
        onecold[sample] = findall(M[:,sample] .== maximum(M[:,sample]))[1]
    end
    return onecold
end

function accuracy(predictor, dataset)
    return mean(onecoldencoding(predictor(dataset[1][1])) .== onecoldencoding(dataset[1][2]))
end

function nettrain(mi::Float64, x_train::Matrix, y_train::Matrix, x_test::Matrix, y_test::Matrix, niter::Int)

    traindataset = [(x_train, y_train)] # batch
    testdataset = [(x_test, y_test)]
    opt = Descent(mi)
    predictor = Chain(Dense(size(x_train, 1), size(y_train, 1), sigmoid), softmax)
    parameters = params(predictor)
    loss(x, y) = Flux.Losses.mse(predictor(x), y)

    train!(loss, parameters, ncycle(traindataset, niter), opt, cb = throttle(() -> println("Training -- ", "Loss: ", loss(x_train, y_train), " train accuracy: ", accuracy(predictor, traindataset), "; test accuracy: ", accuracy(predictor, testdataset)), 2))

    return predictor, parameters
end

