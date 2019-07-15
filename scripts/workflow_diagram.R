###################
### R script to generate a figure illustrating how to integrate data documentation into workflow
### Image will be included in the intro.Rmd file of this data-package-lesson
###################

library(DiagrammeR) ; library(DiagrammeRsvg) ; library(rsvg)


workflw <- grViz("digraph {
                    
                  graph[overlap = true, fontsize = 24, rankdir = BT,
                        outputorder = edgesfirst]
                  
                  node[style = filled, fontname = Helvetica, color = black]

                  subgraph flow{graph[rankdir = LR]
                                node[fillcolor = SandyBrown, shape = oval, margin = 0.2]
                                A[label = 'Acquire raw data']
                                B[label = 'Extract, load, clean data']
                                C[label = 'Data analysis and visulatization']
                                D[label = 'Update docs and reports']
                                E[label = 'Publish results, data, code']
                                
                                rank = same
                                } 
                  
                  subgraph data{graph[rankdir = LR]
                                node[fillcolor = PaleTurquoise1, shape = rectangle, margin = 0.2]
                                F[label = 'Download metadata \nwith data \nfrom repository']
                                G[label = 'Create metadata \nfor self-generated \ndata']
                                H[label = 'Edit or create \nmetadata']
                                I[label = 'Document data \ntransformation \nwith code']
                                J[label = 'Script your \ndata -> visuals \nprocess']
                                K[label = 'Revise metadata for \nyour derived data']
                                L[label = 'Publish your data package \n(metadata + data + scripts)']
                                
                                rank = same
                                edge[style = invisible, dir = none]
                                F -> G -> H -> I-> J -> K -> L 
                                }

                  edge[color = black, arrowhead = vee, arrowsize = 1.25]
                  A -> B 
                  B -> C
                  C -> D 
                  D -> E 
                  F -> A
                  G -> A
                  H -> B
                  I -> B
                  J -> C
                  K -> D
                  L -> E
                  
                 }")



export_svg(workflw) %>% charToRaw() %>% rsvg() %>% png::writePNG("./docs/assets/images/wrkflow_diagram.png")                  

