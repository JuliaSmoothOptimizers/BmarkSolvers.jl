# Test all table output
function test_tables()
  Random.seed!(0)
  n = 10
  names = [:alpha, :beta, :gamma]
  stats = Dict(name => DataFrame(:id => 1:n,
                                 :status => map(x -> x ? :success : :failure, rand(n) .< 0.75),
                                 :f => randn(n),
                                 :t => 1e-3 .+ rand(n) * 1000,
                                 :iter => rand(10:10:100, n),
                                 :irrelevant => randn(n)) for name in names)

  @info("Show all table output for single solver")
  df = stats[:alpha]
  cols = [:status, :f, :t, :iter]

  @info("alpha results in DataFrame format")
  println(df[cols])

  @info("alpha results in latex format")
  header = Dict(:status => "flag", :f => "\\(f(x)\\)", :t => "time")
  latex_tabular_results(stdout, df, cols=cols, hdr_override=header)
end

test_tables()