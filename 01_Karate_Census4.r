# [Notes for next time]
# Dyads and triads
# Undirected and directed
# Appropriate settings for “from” and “to” (Understanding of background)
# Explosion of data volume

library(igraph)           
# Load igraph package for network analysis
# Zachary's Karate Club network

karate <- make_graph("Zachary") 

vertices_df <- data.frame(id = V(karate))
edges_df <- as_data_frame(karate, what = "edges")

print(vertices_df) # Node information (who is there)
print(edges_df)    # Edge information (who is connected to whom)

png("C:\\Users\\hanay\\Downloads\\karate_plot.png", width=1200, height=1600, res=72)
# Split screen into two rows and two columns
par(mfrow = c(2, 2), mar = c(2, 2, 3, 2)) 


# --------------------------------------------
# <1>
# Plot the network using a force-directed layout for better visualization
plot(
  karate,
  layout = layout_with_fr,    # Use Fruchterman-Reingold layout
  vertex.label = V(karate)$name,  # Show vertex names as labels
  vertex.color = "skyblue",   # Set vertex color to sky blue
  edge.arrow.size = 0.5,      # Adjust edge arrow size
  main = "(1) Karate Club Network" # Add title to the plot
)

# Calculate triad census to count the types of triads in the network
# This is an Undirected Graph
triad_census(karate)
# The “directional three-party relationship patterns” commonly used in directed graphs are not distinguished, and the number of triangular structures for undirected graphs is roughly counted.
# Return value: Returns the number of each of the 16 types of three-party relationship patterns as a vector.

# Calculate the global clustering coefficient to measure the overall tendency of triads to close
transitivity(karate, type = "global")
# An indicator that shows how connected the adjacent nodes of a given node are (i.e., how closed the triangle is).
# The higher the value, the more dense the group is, meaning that “friends of friends are also friends.”
#Return value: A value between 0 and 1, with values closer to 1 indicating a network with more triangles.
#For example, 0.2556818 indicates that triangles are formed with a density of approximately 25.5%.


# --------------------------------------------

# <2>
# Extract the ego network (1-step neighborhood) of node 1
ego_net <- make_ego_graph(karate, order = 1, nodes = 1)[[1]]

# Plot the ego network with a circular layout for clarity
plot(
  ego_net,
  layout = layout_in_circle,
  vertex.label = V(ego_net)$name,
  vertex.color = "orange",    # Color vertices orange
  main = "(2) Ego Network of Node 1" # Add title
)

# Calculate triad census on the ego network
triad_census(ego_net)
# Triad aggregation limited to the ego network within one step of Node 1.
# Calculations are performed only on the subnetwork consisting of Node 1 and the nodes directly connected to it.
vcount(ego_net)
# Partial network containing node 1 and 16 people directly connected to node 1
# There are a total of 680 groups when selecting three nodes from among 17 nodes.


# --------------------------------------------

# <3>
# Calculate degree (number of connections) for each vertex in the network
degree(karate)

# Visualize the network with vertex size proportional to degree
plot(
  karate,
  vertex.size = degree(karate) * 2,  # Scale vertex size by degree for visibility
  vertex.color = "lightgreen",        # Set vertex color to light green
  main = "(3) Node Degree as Size"        # Add title
)

# <4>
# Community detection (Louvain)
com <- cluster_louvain(karate)

# Visualize the community structure
plot(
  com,
  karate,
  vertex.label = V(karate),
  main = "(4) Community detection (Louvain)"
)

# --------------------------------------------

dev.off()

