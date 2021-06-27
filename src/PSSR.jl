module PSSR

include("./Classifier.jl"), include("./Read.jl")

# Write your package code here.

x, y = read()
X, Y = classifier(x, y, 3)

end