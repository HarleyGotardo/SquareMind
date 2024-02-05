# QuickStock (Square Mind)
### Project Description
### Target: 

<div style="display: flex;">

  <div style="background-color: #f4f4f4; padding: 1em; width: 300px;">


  - [Revision](../MAIN_MD/1_SQUAREMIND_Revision.md)     
  - [Authentication](../MAIN_MD/2_SQUAREMIND_Authentication.md)
  > - [Create Account](../1_SQUAREMIND_Authentication/1_CreateAccount.md)
  > - [Log in](../1_SQUAREMIND_Authentication/2_LogIn.md)

  - [Manage Inventory](../MAIN_MD/3_SQUAREMIND_ManageInventory.md) 
  - [Cloud Integration](../MAIN_MD/4_SQUAREMIND_CloudIntegration.md)
  </div>

  <div style="flex-grow: 1; padding: 1em;">

  </div>
</div>

______
>
# Data Dictionary
| Element ID | Element Text| Element Type | Data Type | Required? | Rules |
|------------|------------|------------|------------|------------|------------|
| RegistrationHeader | Register an Account for Mobile Inventory Management System Online Database | Header | Text |..|..|
| RegisteredCredential | ContactInfornation | Text | Text | Yes | Must be a legitimate mobile number or email address|
| VerificationCode | Verification Code | Text | Text | Yes | Must be 6 digits |
| UserPassword | Password | Password | Text | Yes | Hidden |
| InvalidCredentials | Invalid username and password. | Text |..|..| Hidden |
| RegistrationButton | Register | Button |..| Yes |..|
| LoginButton | Log in | Button |..| Yes |..|
