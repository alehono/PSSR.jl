module PSSR

using ProgressMeter: showprogress
using ProgressMeter
using Flux
using Flux: train!
using Flux: throttle
using IterTools

export get_protein_data
include("./get_protein_data.jl")

export prepare_data
include("./prepare_data.jl")

export nettrain
include("./Neural_network.jl")

# Write your package code here.

end