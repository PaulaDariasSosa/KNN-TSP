# Solución al Problema del Viajante (TSP) con Ajustes Dinámicos usando KNN

Este repositorio implementa una solución básica al Problema del Viajante (TSP, por sus siglas en inglés) y extiende la funcionalidad para ajustar dinámicamente las distancias entre ciudades simulando bloqueos de rutas mediante predicciones con k-Nearest Neighbors (KNN). El código está desarrollado en Julia y utiliza posiciones aleatorias de ciudades para simular escenarios.

---

## Características

1. **Solución básica al TSP**:
   - Encuentra la ruta más corta para visitar todas las ciudades sin factores dinámicos.
   - Usa un algoritmo voraz para simplificar la implementación.

2. **Ajustes dinámicos de distancias**:
   - Simula bloqueos en rutas específicas.
   - Utiliza predicciones de KNN para ajustar dinámicamente las distancias.

3. **Comparación de resultados**:
   - Compara los costos y rutas obtenidos por:
     - El TSP básico sin bloqueos.
     - El TSP básico con bloqueos.
     - El TSP ajustado dinámicamente con KNN.

---

## Requisitos

Asegúrate de tener Julia instalado en tu sistema. Este proyecto utiliza los siguientes paquetes:

- [NearestNeighbors.jl](https://github.com/KristofferC/NearestNeighbors.jl)
- [Combinatorics.jl](https://github.com/JuliaMath/Combinatorics.jl)
- [Random](https://docs.julialang.org/en/v1/stdlib/Random/)

Para instalar los paquetes necesarios, ejecuta en Julia:

```julia
using Pkg
Pkg.add("NearestNeighbors")
Pkg.add("Combinatorics")
```
## Descripción del Código

### Módulos y Librerías
- **`NearestNeighbors`**: Para predicciones con KNN y simulación de ajustes dinámicos.
- **`Random`**: Genera posiciones aleatorias para las ciudades.
- **`Combinatorics`**: Admite cálculos combinatorios si son necesarios.

### Constantes y Funciones Principales
1. **`NUM_CITIES`**:
   - Define el número de ciudades para la simulación.

2. **`calculate_distance(city1, city2)`**:
   - Calcula la distancia euclidiana entre dos ciudades.

3. **`calculate_initial_distances(positions)`**:
   - Genera un diccionario de distancias entre pares de ciudades.

4. **`tsp_basic(distances, num_cities)`**:
   - Resuelve el TSP básico usando un enfoque voraz.

5. **`knn_adjust_distances(distances, blocked_route, k_neighbors=1)`**:
   - Ajusta las distancias dinámicamente basándose en predicciones de KNN.

6. **`tsp_with_knn(distances, blocked_route, num_cities)`**:
   - Integra las distancias ajustadas en la solución al TSP.

---

## Uso

1. Clona este repositorio y navega a su directorio.

2. Instala los paquetes necesarios ejecutando:

   ```julia
   using Pkg
   Pkg.add("NearestNeighbors")
   Pkg.add("Combinatorics")
   ```
3. Ejecuta el script usando Julia:
   ```bash
   julia tsp_knn.jl
   ```
 4. El programa realizará lo siguiente:
    - Generará posiciones aleatorias para las ciudades.
    - Resolverá el TSP sin factores dinámicos.
    - Simulará un bloqueo en una ruta específica.
    - Recalculará la solución del TSP ajustando las distancias con KNN.
    - Imprimirá los resultados comparativos.
