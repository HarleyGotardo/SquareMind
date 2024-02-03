- [Authentication](../MAIN_MD/2_SQUAREMIND_Authentication.md) > Login

<img src="https://github.com/HarleyGotardo/square-mind/assets/111520613/239eccf2-1514-4027-805e-302c1465f9a1" alt="Add Product" width="300"/>

# User Login
> This is used to authenticate the user with the application.

## Input:
  ● To login, the user must enter his or her credentials.

## Process:
  ● The user shall enter his or her email address or mobile number.
  
  ● The user shall enter his or her password.
  
  ● The user shall tap the “Login” button.

## Output:
  ● The user shall be logged into the application by the system.

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
