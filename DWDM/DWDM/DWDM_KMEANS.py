import numpy as np
import matplotlib.pyplot as plt
from sklearn import datasets
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
iris = datasets.load_iris()
X = iris.data
X_scaled = X
wcss = []

for k in range(1, 11):
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X_scaled)
    wcss.append(kmeans.inertia_)

plt.figure(figsize=(8, 6))
plt.plot(range(1, 11), wcss, marker='o', linestyle='--')
plt.title('elbow graph')
plt.xlabel('clusters n')
plt.ylabel('wcss')
plt.xticks(np.arange(1, 11, step=1))
plt.grid(True)
plt.show()

kmeans = KMeans(n_clusters=3)
kmeans.fit(X_scaled)

centroids = kmeans.cluster_centers_
labels = kmeans.labels_

pca = PCA(n_components=2)
X_pca = pca.fit_transform(X_scaled)
plt.figure(figsize=(8, 6))
plt.scatter(X_pca[:, 0], X_pca[:, 1], c=labels, cmap='viridis', marker='o')
plt.scatter(pca.transform(centroids)[:, 0], pca.transform(centroids)[:, 1], s=300, c='red', label='Centroids')
plt.title('K-Means Clustering')
plt.legend()
plt.show()
