setwd("D:/Documents/Document/JOI/Data/SAOM")
library(RSiena)

# Define data sets
collaborationP1 <- as.matrix(read.table("Collaboration Network-1.dat"))
collaborationP2 <- as.matrix(read.table("Collaboration Network-2.dat"))
collaborationP3 <- as.matrix(read.table("Collaboration Network-3.dat"))
collaborationP4 <- as.matrix(read.table("Collaboration Network-4.dat"))
collaborationP5 <- as.matrix(read.table("Collaboration Network-5.dat"))

networkSizeNode <- as.matrix(read.table("1 Network Size Node-L.dat"))
networkModularity <- as.matrix(read.table("2 Network Modularity-L.dat"))
networkTransitivity <- as.matrix(read.table("3 Network Transitivity-L.dat"))
combinatorialPower <- as.matrix(read.table("4 Combinatorial Power-G.dat"))
orgTpye <- as.matrix(read.table("5 Organization Type.dat"))
organizationalProximity <- as.matrix(read.table("6 Organizational Proximity.dat"))
subgraphF1 <- as.matrix(read.table("0 Subgraph F1.dat"))
subgraphF2 <- as.matrix(read.table("0 Subgraph F2.dat"))
subgraphF4 <- as.matrix(read.table("0 Subgraph F4.dat"))

cognitiveProximityP1 <- as.matrix(read.table("Cognitive proximity-1.dat"))
cognitiveProximityP2 <- as.matrix(read.table("Cognitive proximity-2.dat"))
cognitiveProximityP3 <- as.matrix(read.table("Cognitive proximity-3.dat"))
cognitiveProximityP4 <- as.matrix(read.table("Cognitive proximity-4.dat"))


# Dependent variable construction
collaborationData <- array(c(collaborationP1, collaborationP2, collaborationP3, collaborationP4, collaborationP5),dim = c(346, 346, 5))
collaboration <- sienaDependent(collaborationData)

# Actor co-variates construction
network_Size_Node <- varCovar(networkSizeNode)
network_Modularity <- varCovar(networkModularity)
network_Transitivity <- varCovar(networkTransitivity)
combinatorial_Power <- varCovar(combinatorialPower)
subgraph_F1 <- varCovar(subgraphF1)
subgraph_F2 <- varCovar(subgraphF2)
subgraph_F4 <- varCovar(subgraphF4)
org_Type <- coCovar(orgTpye[ , 1 ])

organizational_proximity <- coDyadCovar(organizationalProximity)
cognitive_proximity <- varDyadCovar(array(c(cognitiveProximityP1, cognitiveProximityP2, cognitiveProximityP3,cognitiveProximityP4),dim = c(346, 346, 4)))

mydata <- sienaDataCreate(collaboration, network_Size_Node, network_Modularity, network_Transitivity, org_Type, 
                          combinatorial_Power, organizational_proximity,cognitive_proximity,subgraph_F1,subgraph_F2,subgraph_F4)  

# Effects object
myeff <- getEffects(mydata)
effectsDocumentation(myeff)
myeff <- includeEffects(myeff, density, transTriads)
myeff <- includeEffects(myeff, egoX, interaction1 = "network_Size_Node")
myeff <- includeEffects(myeff, egoX, interaction1 = "network_Modularity")
myeff <- includeEffects(myeff, egoX, interaction1 = "network_Transitivity")
myeff <- includeEffects(myeff, egoX, interaction1 = "combinatorial_Power")
myeff <- includeEffects(myeff, egoX, interaction1 = "org_Type")
myeff <- includeEffects(myeff, X, interaction1 = "organizational_proximity")
myeff <- includeEffects(myeff, X, interaction1 = "cognitive_proximity")
myeff <- includeEffects(myeff, egoX, interaction1 = "subgraph_F1")
myeff <- includeEffects(myeff, egoX, interaction1 = "subgraph_F2")
myeff <- includeEffects(myeff, egoX, interaction1 = "subgraph_F4")

myeff

# Algorithm
myalgorithm <- sienaAlgorithmCreate(projname = 'result', seed = 8, n3 = 3000, nsub = 5) 
ans <- siena07( myalgorithm, data = mydata, effects = myeff)
ans
ans$tconv.max
