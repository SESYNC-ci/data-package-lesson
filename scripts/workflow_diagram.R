###################
### R script to generate a figure illustrating how to integrate data documentation into workflow
### Image will be included in the intro.Rmd file of this data-package-lesson
###################

library(DiagrammeR) ; library(DiagrammeRsvg) ; library(rsvg) 

workflw <- grViz("digraph {
                    
                  graph[outputorder = edgesfirst, layout = circo, mindist = 1.5]
                  
                  node[style = filled, fontname = Helvetica, color = black]

                  node[fillcolor = midnightblue, fontcolor = white, fontsize = 20,
                       shape = circle, margin = 0.05, width = 2.25, height = 2.25]
                  A[label = 'Acquire \nraw data', fixedsize = shape]
                  B[label = 'Extract, load, \nclean data', fixedsize = shape]
                  C[label = 'Data analysis \nand \nvisulatization', fixedsize = shape]
                  D[label = 'Update docs \nand reports', fixedsize = shape]
                  E[label = 'Publish results, \ndata, code', fixedsize = shape]
                                
                  node[fillcolor = aquamarine1, fontcolor = black, shape = circle, margin = 0.01,
                       width = 1.25, height = 1.25, fontsize = 16]
                  F[label = 'Download \nmetadata with \ndata from \nrepository']
                  G[label = 'Create metadata \nfor self-generated \ndata']
                  H[label = 'Edit or create \nmetadata']
                  I[label = 'Document data \ntransformation \nwith code']
                  J[label = 'Script your \ndata -> visuals \nprocess']
                  K[label = 'Revise metadata \nfor your \nderived data']
                  L[label = 'Publish your \ndata package \n(metadata + data + \nscripts + visuals)']


                  edge[color = black, arrowhead = vee, arrowsize = 1.25]
                  A -> B 
                  B -> C
                  C -> D 
                  D -> E 
                  E -> A
                  F -> A
                  G -> A
                  H -> B
                  I -> B
                  J -> C
                  K -> D
                  L -> E
                  
                 }")


export_svg(workflw) %>% charToRaw() %>% rsvg() %>% png::writePNG("./docs/assets/images/wrkflow_diagram.png")                  


