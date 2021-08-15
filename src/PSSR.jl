module PSSR
# External package
using Revise
using ProgressMeter: showprogress
using ProgressMeter
using Flux
using Flux: train!
using Flux: throttle
using IterTools
using Statistics: mean

# Program packages
export get_protein_data
include("./get_protein_data.jl")

export check_data
export count_size
include("./test.jl")

export prepare_data
export build_matrix_X
export build_matrix_Y
include("./prepare_data.jl")

export nettrain
export accuracy
export onecoldencoding
include("./Neural_network.jl")

export write_dataset
include("./write_dataset.jl")
# Write your package code here.


end