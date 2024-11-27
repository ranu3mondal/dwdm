import pandas as pd
import matplotlib.pyplot as plt
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.metrics import classification_report, confusion_matrix

iris = load_iris()
X = iris.data
y = iris.target

y = pd.DataFrame(y, columns=['Species'])

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)

model = DecisionTreeClassifier(random_state=42)
model.fit(X_train, y_train)

y_pred = model.predict(X_test)

print("Confusion Matrix:")
print(confusion_matrix(y_test, y_pred))
print("\nClassification Report:")
print(classification_report(y_test, y_pred, target_names=iris.target_names))

importances = model.feature_importances_
feature_importance = pd.DataFrame({'Feature': iris.feature_names, 'Importance': importances})
feature_importance = feature_importance.sort_values(by='Importance', ascending=False)

print("\nFeature Importances:")
print(feature_importance)

plt.figure(figsize=(20, 10))
plot_tree(model, filled=True, feature_names=iris.feature_names, class_names=iris.target_names, 
          rounded=True, fontsize=12)
plt.title('Decision Tree Visualization on Iris Dataset')
plt.show()
