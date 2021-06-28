module PSSR

include("./Classifier.jl"), include("./Read.jl")

# Write your package code here.

x, y = read(path)
X, Y = classifier(x[1], y[1], 3)

end