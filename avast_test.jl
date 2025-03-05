
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

schema_parts = tmap(x -> JsonGrinder.schema(x), jsons)
schema = merge(schema_parts...)

extractor = suggestextractor(schema)
data = tmap(extractor, jsons)
display(data)