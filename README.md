# Android-Based Sari-Sari Store Inventory and Sales Management System Design Specifications (Square Mind)
### The project aims to develop an Android-based sales and inventory management system for sari-sari stores. Currently, sari-sari stores manage their inventory and sales using paper-based or non-existent systems. This makes tracking inventory levels and sales data time-consuming as the store grows. The proposed system will allow sari-sari store owners to manage their inventory, record sales transactions, and generate sales reports using a mobile application. Key features include adding, editing, and removing inventory items, recording product sales, barcode scanning, and generating daily/weekly/monthly sales graphs. The system is designed to work offline but also integrate with an online database for data synchronization. This will ensure up-to-date data across devices. As Android is widely used, it will be the exclusive platform. Strong database security is also included to protect sensitive business data. The goal is to provide sari-sari store owners with a simple yet secure way to streamline their operations by digitizing paper-based processes. The user interface will be easy to use for all ages. This aims to improve business processes and access to real-time inventory and sales information.

| Internal Release Code    | Version | Date Released |
|----------|------------|-------------------|
| SM.010.000 | v1.0.0   | 2024-02-06 22:37:03 | 
| SM.020.004 | v2.0.0   | 2024-02-11 22:31:40|
| SM.020.008 | v2.0.0   | 2024-03-15 22:31:40| 

## Releases
### SM.010.000
- Implemented the Login and Registration Page UI of the system
- A transition from the login page to the registration page states has been implemented.
- Simple Login Page
- Added "const" from line 30
- Added appBar in Scaffold
- Created Separate File for Login Screen
- Added a registration screen, when the register button is pressed, it will go to the login page. 
- Added the progress during Feb. 2, 2024

### SM.020.004
- Update main_page.dart with enhancements to Dashboard, Inventory Management, and SalesRecordPage
- This commit includes several updates to the main_page.dart file:
- Dashboard: Added card widgets.
- Inventory Management: Added simple inventory implementation.
- SalesRecordPage: 
  - Added a 'date' attribute to the SalesRecord class.
  - Updated the DataTable to include a new column for the date.
  - Modified the AppBar title to include a sales icon and the title 'Sales Record'.
  - Fixed an overflow issue in the DataTable by limiting the width of the columns.
- Further enhanced the login and registration page UI.
- Separates the different screen files for the main page.
- Added more widgets in Inventory Management and Cloud Integration Page.

### SM.020.008
- Added the add item feature.
- Added the delete feature using long press.
- Improved the UI elements in inventory management section.
- Added additional constraints and modified user experience.
- Added a date picker in date input field.
- Added the update item functionality.
- Improved text field ui in edit item feature, and added constraints.

## Important Links
- Design Specs: [Design Specifications](https://github.com/HarleyGotardo/square-mind/blob/main/README_FILES/MAIN_MD/DesignSpecificationDocument.md)
- Apk Releases: [Apks](https://github.com/HarleyGotardo/squaremind-apk-releases)

# test
