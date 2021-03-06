library(testthat)

test_that("GNG Utility works", {
    print("GNG Utility works")
  
    max_nodes <- 500

    # Construct gng object
    gng <- GNG(max.nodes=max_nodes, train.online=TRUE, dim=3, verbosity=3, k=1.3)

    # Construct examples, here we will use a sphere
    ex <- gng.preset.sphere(N=10000)
    labels <- round(runif(10000)*3)
    insertExamples(gng, ex, labels)

    # Run algorithm in parallel
    run(gng)
    meanError(gng)


    # Wait for it to converge
    print("Adding juped distribution. 15s sleep")
    Sys.sleep(15.0)
    pause(gng)
    plot(gng, mode="2d.errors") #0.068 without utility , 10 times less with

    ex2 <- gng.preset.cube(N=10000, r=1.0, center=c(3.0,3.0,3.0))
    insertExamples(gng, ex2, labels)


    run(gng)
    print("Test::Jumped distribution added. 15s sleep")
    Sys.sleep(15.0)
    pause(gng)
    plot(gng, mode="2d.errors")

    g <- convertToIGraph(gng)
    length(V(g))

    if("rgl" %in% rownames(installed.packages()) == TRUE) {
      plot(gng, mode=gng.plot.3d)
    }



    print("Test::Graph after jumped distribution")

    ig <- convertToIGraph(gng)

    # Running unit tests (almost)
    test_that("GNG has not isolated vertexes", {
      expect_that(any(degree(ig)==0), is_false()) 
    })

    print("Test::No isolated vertexes")


    test_that("GNG has converged", {
      error_before = meanError(gng)
      expect_that(error_before < 50/max_nodes, is_true() )
    })

    print("Test::Convergence test")

    terminate(gng)
    
    expect_that(isRunning(gng) == FALSE, is_true())
})
