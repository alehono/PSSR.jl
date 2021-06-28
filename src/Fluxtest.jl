using Flux
using Flux: train!

actual(x) = 4x + 2

x_train, x_test = hcat(0:5...), hcat(6:10...)
y_train, y_test = actual.(x_train), actual.(x_test)

opt = Descent()

data = [(x_train, y_train)]

predict = Dense(1, 1)

parameters = params(predict)

loss(x, y) = Flux.Losses.mse(predict(x), y)

for epoch in 1:200
    train!(loss, parameters, data, opt)
end

loss(x_train, y_train)

parameters