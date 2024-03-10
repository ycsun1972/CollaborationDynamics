# CollaborationDynamics

This is our research code for the paper: How network embeddedness and knowledge stock influence collaboration dynamics? Evidence from patents

This paper constructs multilayer longitudinal networks, employing the Stochastic Actor-Oriented Model (SAOM) to explore the influence of network embeddedness and knowledge stock on collaboration dynamics. Our methodology leverages graphlet identification modules, knowledge element extraction techniques, network analysis approaches, and SAOM network dynamic modeling. This document primarily presents Python-based code for subgraph extraction and R-based code for SAOM modeling.

## Released Items
- Collaboration network stored in Excel
- Codes for graphlet identification
- The input of the SAOM comprises 19 DAT files
- Codes for SAOM 


## Preliminary Preparations

### Install toolkits
```
Python-igraph
R-RSiena
```

## Graphlet identification

We identify the graphlets within the collaboration networks of organizations. These collaboration networks are stored in the file “Collaboration network”. The codes applied for the identification process of these graphlet are available in the “Subgraph detection” file.

## SAOM dynamic network modeling

The SAOM requires inputs from three variable categories: network structure, node attributes, and proximity. These variables, stored as matrices or vectors, can be found in “SAOM Input”, which contains a total of 19 DAT files.
Codes for SAOM modeling are provided in the R file “SAOM”.

## Citation
To be updated