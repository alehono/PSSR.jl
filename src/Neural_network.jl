predictor = Chain(Dense(1, 1), softmax)

function nettrain(predictor, mi::Float64, x_train, y_train, x_test, y_test, niter::Int)

    traindataset = [(x_train, y_train)] # batch
    testdataset = [(x_test, y_test)]
    opt = Descent(mi)
    parameters = params(predictor)
    loss(x, y) = Flux.Losses.mse(predictor(x), y)

    train!(loss, parameters, ncycle(traindataset, niter), opt, cb = throttle(() -> println("Training"), 2))

    return parameters
end

function accuracy(x, y)
    return median(predictor(x) == y)
end