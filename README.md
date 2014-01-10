# DBScan

DBScan is a data clustering algorithm that finds a number of clusters starting from the estimated density distribution of corresponding nodes. 

#### Table of Contents

- [Short Explaination of the Algorithm](#algorithm)
- [Usage](#usage)
- [Author](#author)
- [License](#license)

## Short Explaination of the Algorithm

DBScan requires two parameters: an epsilon and the minimum number of points required to form a cluster. It starts with an arbitrary starting point that has not been visited. This point's epsilon-neighborhood is retrieved, and if it contains sufficiently many points, a cluster is started. Otherwise, the point is labeled as noise. Note that this point might later be found in a sufficiently sized epsilon-environment of a different point and hence be made part of a cluster. 

If a point is found to be a dense part of a cluster, its epsilon-neighborhood is also part of that cluster. Hence, all points that are found within that epsilon-neighborhood are added, as is their own epsilon-neighborhood when they are also dense. This process continues until the density-connected cluster is completely found. Then, a new unvisited point is retrieved and processed, leading to the discovery of a further cluster or noise.

## Usage

An example of how to use the DBScan implementation can be found in the [Sources/main.m](Sources/main.m) file.

## Author

Christian Vogel

## License

Usage is provided under the [MIT License](http://opensource.org/licenses/MIT).



