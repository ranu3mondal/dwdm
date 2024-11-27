import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules
import warnings 
warnings.filterwarnings("ignore")

data = pd.read_csv("C:\\Users\\Vaishnavi\\Documents\\BTech\\TY\\Sem 5\\DWDM\\online_retail.csv", encoding='ISO-8859-1')

data = data.dropna(subset=['CustomerID'])

data['InvoiceDate'] = pd.to_datetime(data['InvoiceDate'], dayfirst=True)

basket = data.groupby(['InvoiceNo', 'Description'])['Quantity'].sum().unstack().reset_index().fillna(0)
basket = basket.set_index('InvoiceNo')
basket = basket.applymap(lambda x: 1 if x > 0 else 0)

print("Basket format:")
print(basket.head())

frequent_itemsets = apriori(basket, min_support=0.02, use_colnames=True)

print("\nFrequent itemsets:")
print(frequent_itemsets)

rules = association_rules(frequent_itemsets, metric='lift', min_threshold=0.5)

print("\nAssociation rules:")
print(rules)
