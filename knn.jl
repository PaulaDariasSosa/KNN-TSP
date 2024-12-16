using Pkg
Pkg.add("NearestNeighbors")
Pkg.add("Combinatorics")
using NearestNeighbors
using Random
using Combinatorics
# Número de ciudades
const NUM_CITIES = 5

# Generar posiciones aleatorias para las ciudades
positions = rand(2, NUM_CITIES)

# Calcular distancias entre las ciudades
function calculate_distance(city1, city2)
    return sqrt((city1[1] - city2[1])^2 + (city1[2] - city2[2])^2)
end

# Crear matriz de distancias sin factores dinámicos (básica)
function calculate_initial_distances(positions)
    num_cities = size(positions, 2)
    distances = Dict()
    for i in 1:num_cities-1
        for j in i+1:num_cities
            dist = calculate_distance(positions[:, i], positions[:, j])
            distances[(i, j)] = dist
        end
    end
    return distances
end

# Resolver TSP básico sin KNN
function tsp_basic(distances, num_cities)
    visited = falses(num_cities)
    route = []
    total_distance = 0.0
    current_city = 1
    visited[current_city] = true
    push!(route, current_city)

    for _ in 2:num_cities
        next_city = -1
        min_distance = Inf
        for city in 1:num_cities
            if !visited[city] && haskey(distances, (min(current_city, city), max(current_city, city)))
                dist = distances[(min(current_city, city), max(current_city, city))]
                if dist < min_distance
                    min_distance = dist
                    next_city = city
                end
            end
        end
        if next_city != -1
            push!(route, next_city)
            visited[next_city] = true
            total_distance += min_distance
            current_city = next_city
        end
    end
    total_distance += distances[(min(route[end], 1), max(route[end], 1))]
    return route, total_distance
end

# Simular predicción con KNN para ajustar distancias
function knn_adjust_distances(distances, blocked_route, k_neighbors=1)
    historical_data = reshape(rand(10), 1, :)  # Simulated data
    query_point = reshape([1.0], 1, :)  # Query point

    # Build KDTree and find nearest neighbors
    tree = KDTree(historical_data)
    idxs, dists = knn(tree, query_point, k_neighbors)

    # Ajustar distancias basadas en predicción de atasco
    adjusted_distances = copy(distances)
    if haskey(adjusted_distances, blocked_route)
        println("Penalizando ruta bloqueada: ", blocked_route)
        adjusted_distances[blocked_route] += 1000.0  # Penalización extrema
    end
    println("Distancias ajustadas: ", adjusted_distances)
    return adjusted_distances
end

# Resolver TSP con distancias ajustadas por KNN
function tsp_with_knn(distances, blocked_route, num_cities)
    adjusted_distances = knn_adjust_distances(distances, blocked_route)
    return tsp_basic(adjusted_distances, num_cities)
end

# TSP básico sin ajustar factores dinámicos
initial_distances = calculate_initial_distances(positions)
route_basic, cost_basic = tsp_basic(initial_distances, NUM_CITIES)

println("\nRuta básica sin KNN:")
println("Costo total inicial: ", cost_basic)
println("Ruta visitada: ", route_basic)

# Simular el atasco después de resolver sin KNN
blocked_route = (min(route_basic[2], route_basic[3]), max(route_basic[2], route_basic[3]))
if haskey(initial_distances, blocked_route)
    println("Aumentando costo de la ruta bloqueada: ", blocked_route)
    initial_distances[blocked_route] += 1000.0  # Penalización significativa
end

# Recalcular el costo real tras el atasco
_, cost_with_blockage = tsp_basic(initial_distances, NUM_CITIES)
println("\nCosto total tras el atasco (sin conocimiento previo): ", cost_basic+1000)

# Resolver con distancias ajustadas por KNN
route_knn, cost_knn = tsp_with_knn(calculate_initial_distances(positions), blocked_route, NUM_CITIES)

println("\nRuta ajustada con KNN y datos históricos:")
println("Costo total ajustado: ", cost_knn)
println("Ruta optimizada considerando atasco: ", route_knn)

# Comparación de resultados
println("\nComparación de resultados:")
println("- Costo sin KNN, sin atasco: ", cost_basic)
println("- Costo sin KNN, con atasco: ", cost_basic+1000)
println("- Costo con KNN: ", cost_knn)
