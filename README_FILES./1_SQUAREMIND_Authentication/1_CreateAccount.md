# QuickStock (Square Mind)
### Project Description
### Target: 

<div style="display: flex;">

  <div style="background-color: #f4f4f4; padding: 1em; width: 300px;">
    <h2>Sidebar</h2>

  - [Revision](../README_FILES./1_SQUAREMIND_Revision.md)     
  - [Authentication](../README_FILES./2_SQUAREMIND_Authentication.md)
  > - [Create Account](../README_FILES./1_SQUAREMIND_Authentication/1_CreateAccount.md)
  > - [Log in](../README_FILES./1_SQUAREMIND_Authentication/2_LogIn.md)

  - [Manage Inventory](../README_FILES./3_SQUAREMIND_ManageInventory.md) 
  - [Cloud Integration](../README_FILES./4_SQUAREMIND_CloudIntegration.md)
  </div>

  <div style="flex-grow: 1; padding: 1em;">

  # Create Account
> This is used to register the user to an online database.

## Input:
  ● The user shall fill in the credential input.

## Process:
  ● The user shall enter his or her phone number or email address.
  ● The user shall tap the “Register” button.

## Output:
  ● The registration is filled and is submitted for verification.

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

  </div>
</div>


