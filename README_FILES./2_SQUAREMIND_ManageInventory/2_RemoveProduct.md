- [Manage Inventory](../MAIN_MD/3_SQUAREMIND_ManageInventory.md) > Add Product

<img src="https://github.com/HarleyGotardo/square-mind/assets/111520613/c7110ebc-9212-47f2-8545-48355f07d652" alt="Add Product" width="300"/>

# Remove Product
> This is used for deleting selected product(s) from the inventory.

## Input:
  ● The user shall select the product(s) that he or she desired to be removed from the inventory.

## Process:
  ● The user shall long tap the product in the inventory.
  ● The user shall tap the other products that he or she desires to remove.
  ● The user shall tap the “Remove” button.

## Output:
  ● The system has to remove the selected products and update the inventory

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
