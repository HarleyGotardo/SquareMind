- [Manage Inventory](../MAIN_MD/3_SQUAREMIND_ManageInventory.md) > Product Sales and Report
  
<img src="https://github.com/HarleyGotardo/square-mind/assets/111520613/758e9eee-0936-4bdd-85d2-73d65aa01988" alt="Add Product" width="300"/>

## Product Sales and Report
> This is used for recording the sales of the products and  used to generate a graphical representation of the total sales record.

## Input:
  ● The user shall choose what product is being sold and specify the quantity.
  ● The user shall choose the type of graphical representation of the sales record

## Process:
  ● The user shall search for the product that the customer wants to buy
  ● The user shall choose the product that’s being sold.
  ●  The user shall specify the quantity.
  ● The user shall tap on the “Sold Product”.
  ● The user shall tap on either daily/weekly/monthly/yearly graph of the sales.

## Output:
  ● The system shall automatically add that product to the list of sold products and calculate the total sales amount.
  ● The system shall automatically display the graphical representation of the sales data.

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
