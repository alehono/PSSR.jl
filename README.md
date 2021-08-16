# PSSR

## How to use

Download and extract the files in a directory. 

### Reading the files:

You can use the function `get_protein_data` to read the sequences and structures of the proteins, 
providing the path including the folder where the files were extracted to, as the example:

`seq, str = get_protein_data("complete/directory/to_the/files")`

which will create two arrays; the first containing the aminoacids' in each sequence and the other, the structures assigned to each residue.

### Transforming the files into the training and testing datasets:

To generate the train and test datasets, you can use the function `prepare_data`, which will create four matrices, 
two representing the train and test datasets for the residues and two for the structures. 
This function takes four arguments: the list of sequences, i.e., the first array generated from the previous function; 
a list of structures, i.e., the second array; a window size; and 
the fraction of sequences that will be used for training data, which is set to 0.6 by default.

Here is a example:

`X_train, Y_train, X_test, Y_test = prepare_data(seq, str, 3)`.
