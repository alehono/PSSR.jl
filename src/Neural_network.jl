using Flux
using Flux: train!
using Flux: throttle
using IterTools

function nettrain(mi::Float64, x_train, y_train, x_test, y_test, niter::Int)

    dataset = [(x_train, y_train)] # batch
    opt = Descent(mi)
    predict = Dense(1, 1)
    parameters = params(predict)
    loss(x, y) = Flux.Losses.mse(predict(x), y)
   
    train!(loss, parameters, ncycle(dataset, niter), opt, cb = throttle(() -> println("Training"), 2))

    return parameters
end