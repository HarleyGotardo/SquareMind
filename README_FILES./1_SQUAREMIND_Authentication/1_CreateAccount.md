- [Authentication](../MAIN_MD/2_SQUAREMIND_Authentication.md) > Create Account

<img src="https://github.com/HarleyGotardo/square-mind/assets/111520613/5ab81f72-2553-498b-964c-6ac8603f8c4f" alt="Add Product" width="300"/>

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
