# Android-Based Sari-Sari Store Inventory and Sales Management System Design Specifications (Square Mind)
### The project aims to develop an Android-based sales and inventory management system for sari-sari stores. Currently, sari-sari stores manage their inventory and sales using paper-based or non-existent systems. This makes tracking inventory levels and sales data time-consuming as the store grows. The proposed system will allow sari-sari store owners to manage their inventory, record sales transactions, and generate sales reports using a mobile application. Key features include adding, editing, and removing inventory items, recording product sales, and visualizing daily sales and monthly total sales. The system is designed to work offline but also integrate with an online database for data synchronization. This will ensure up-to-date data across devices. As Android is widely used, it will be the exclusive platform. The goal is to provide sari-sari store owners with a simple way to streamline their operations by digitizing paper-based processes. The user interface will be easy to use for all ages. This aims to improve business processes and access to real-time inventory and sales information.

| Internal Release Code    | Version | Date Released |
|----------|------------|-------------------|
| SM.010.000 | v1.0.0   | 2024-02-06 22:37:03 | 
| SM.020.004 | v2.0.0   | 2024-02-11 22:31:40|
| SM.020.008 | v2.0.0   | 2024-03-15 22:31:40| 
| SM.020.011 | v2.1.0   | 2024-04-14 19:30:31| 
| SM.020.012 | v2.1.0   | 2024-05-03 16:00:00| 
| SM.020.013 | v2.1.0   | 2024-05-12 15:00:00| 
| SM.020.014 | v2.1.0   | 2024-05-19 14:00:00| 
| SM.030.002 | v3.1.0   | 2024-05-21 9:20:00| 

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

### SM.020.011
- Add a new date input field in record.dart.
- Added a link for the apk releases.
- Built an apk for the system and added firebase.
- Recording of sold items is now implemented.
- Added a totalPrice in recording of sold items.
- Added style of app bar in record.dart.

### SM.020.012
- Completed Dashboard Functionality.

### SM.020.013
- BUG - 0001, BUG - 0002 has been fixed.
- Removed the expiry date, barcode, category information in item database. To make the app much simpler.

### SM.020.014
- Firebase Login and Create Account Implemented for Cloud Integration.
- Fixed some routing inconsistencies.
- Also added some sub features:
- When in main page, pressing the back button requires to press it twice to exit the app.
- Added some icon emojis for more colors and life to the app.
- Sharedpreferences implemented.
- Changed the application icon logo to be based on the theme of the system.

### Final: SM.030.002
- Removed the Cloud Integration Page: In this commit. We decided to remove the cloud integration module entirely, due to its hard to implement. We are sorry for this. But let this just be considered as a study for future improvement. Thank you. But several improvement from the other module was implemented. In Inventory Module - Duplicate item names (not case sensitive) will not be added anymore. In Sales Record Module - There is now suggestions to what available item names are existing in the item database.
- Finalizations: (1)Dashboard: Fixed some unscrollable sections. (2)Improved Greetings. (3)New release. (4)Inventory management: if an item is successfully added, it will automatically refresh the page.

## Important Links
- Design Specs: [Design Specifications](https://github.com/HarleyGotardo/square-mind/blob/main/README_FILES/MAIN_MD/DesignSpecificationDocument.md)
- Apk Releases: [Apks](https://github.com/HarleyGotardo/squaremind-apk-releases)


# Test
- Test Case Management: [SquareMindTCM](https://github.com/HarleyGotardo/SquareMindTCM)
