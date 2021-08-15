# PSSR

## How to use

Download and extract the files in a directory. 

### Reading the files:

You can use the function `get_protein_data` to read the sequences and structures of the proteins, 
providing the path including the folder where the files were extracted to, as the example:

`seq, str = get_protein_data("complete/directory/to_the/files")`

which will create two arrays; the first containing the aminoacids' in each sequence and the other, the structures assigned to each residue.
