using Flux
using Flux: train!
using Flux: throttle
using IterTools

actual(x) = 4x .+ 2

x_train = [1 2]
y_train = actual.(x_train)

opt = Descent(0.001)

data = [(x_train, y_train)]

predict = Dense(1, 1)

parameters = params(predict)

loss(x, y) = Flux.Losses.mse(predict(x), y)

#for epoch in 1:2000
train!(loss, parameters, ncycle(data, 100000), opt, cb = throttle(() -> println("treinando"), 0.002))
#end

loss(x_train, y_train)

parameters

print("fool")