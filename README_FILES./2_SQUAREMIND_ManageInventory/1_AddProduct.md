- [Manage Inventory](../MAIN_MD/3_SQUAREMIND_ManageInventory.md) > Add Product


<img src="https://github.com/HarleyGotardo/square-mind/assets/111520613/c805f572-ca80-496e-968d-7e0586d15fe2" alt="Add Product" width="300"/>

# Add Product
> This is used for adding a product into the inventory.

## Input:
  ● The user shall enter all of the product information.

## Process:
  ● The user shall enter the name of the product.
  ● The user shall enter the quantity of the product.
  ● The user shall enter the price of the product.
  ● The user shall enter the expiration date of the product (if it is expirable)

## Output:
  ● The product will be added to the inventory and visualized by the system.

______
>
# Data Dictionary
| Element ID | Element Text| Element Type | Data Type | Required? | Rules |
|------------|------------|------------|------------|------------|------------|
| HeaderTitle | Inverntory Status | Header | Text |..| Centered Text Alignment |  
| InventoryTable |..| Table |..| yes |  |  
| ProdID | Product ID | Text Field | Text | Yes | Must coorespond to a valid product |  
| ProdQuantity | Product Quantity | Text Field | Text | Yes | Must be a positive numner |  
| PordExpDate | Expiration Date | Text Field | Text | No |..|  
| ProdBarcode | Barcode | Barcode | Character | No |  |  
| PodCost | Product Cost | Currency | Number | No | Cost of the production |  
| ProdName | Product Name | Text Field | Text | Yes |..|  
| RemoveButton | Remove | Button |..|..| Removes selected product/s from inventory |  
| EditButton | Edit | Button |..|..| Edit the selected product |  
| Add Button | Add | Button |..|..| Add a product to inventory |  
| SearchEntry | Search | Text Field | Text | Yes | Allow users to search a product |  
