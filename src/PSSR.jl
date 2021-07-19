module PSSR

using ProgressMeter

include("./get_protein_data.jl")
include("./prepare_data.jl")
include("./Neural_network.jl")

# Write your package code here.

sequences, structures = get_protein_data("C:/Users/honoa/IC")
seq_train, struct_train, seq_test, struct_test = prepare_data(sequences, structures, 3)

end