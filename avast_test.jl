
using Pkg
Pkg.activate("./")

using Flux, MLDataPattern, Mill, JsonGrinder, JSON, Statistics, IterTools, StatsBase, ThreadTools
using JsonGrinder: suggestextractor, ExtractDict
using Mill: reflectinmodel
using CSV, DataFrames
using Random
using Dates
using Plots
using Printf

THREADS = Threads.nthreads();

jsons = open("../data/test_features.jsonl") do f
    [JSON.parse(line) for line in eachline(f)]
end

@assert length(jsons) > 0

schema = JsonGrinder.schema(jsons)

extractor = suggestextractor(schema)
data = tmap(extractor, jsons)
df = DataFrame(data)
df = DataFrame([replace(col, nothing => "") for col in eachcol(df)], names(df))
CSV.write("output_mald.csv", df)