# cetac-nd-app

This is the iOS App for CETAC. Built on Xcode using Swift. It wwas designed to help thanatologists and administrators from CETAC, a thanatologic clinic that provides free therapy and holistic treatment spanning a variety of services to people who have faced a recent loss. This front-end interacts with an API to obtain information from the backend, which mainly contains CRUD operations. The backend was architected in AWS, checkout the [APIs repository](https://github.com/CETAC-NetworkDefenders/cetac-apis) for more information. 

The App is divided into four areas, each of them linked to a specific access level. General information, Administrative area, Administrative Support area, and Thanatologists area. Each of them will be briefly described below. 

## General information area

The first one is for general information. The organization requested a space to show users all the information about the services dierectly from a cellphone. Services are organized into categories, and each of them has a description and associated image. In order to allow an easy navigation, each cateogry was placed in a tab, and a Tab Navigation Controller was used as the root controller for the whole application. Some examples are: 

| Holistic Services Category  | Biomagnetism service | Alternative Services Category | Bach Flowers Service |
|---|---|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1xrbF92lPAgS7luLCyX0jDNXOx3kilUaC) | ![image](https://drive.google.com/uc?export=view&id=1vqz719xY36jLW3XhTwFR6NFXd6uJMAWb) | ![image](https://drive.google.com/uc?export=view&id=19_kqOAtD7vao2a5gcfLlWq2gSthNkZav) | ![image](https://drive.google.com/uc?export=view&id=1noqID8tqFhxH8evgrqUpweZvCHjzRKj5) | 

## Administrative and support area

This area is designed for the administrators of the organization. They needed to visualize the Staff, preferably separated by access level, as well as to add new staff to the organization and create app accounts for them. Note that this means that no Sign Up is required, since the administrators themselves register a user and specify credentials. Furthermore, they wanted to get reports of some selected KPIs trough graphs and tables, directly in the app. Note that the Support area is the same as the Administrative one, but some restrictions apply on the access to certain functionalities. 

### Login and main menu

The first functionality that a user faces is the Login, since they must first authenticate to determine which kind of information, if at all, should be shown to them. The Login screen is pretty simple, the user does not have to indicate her access level, but rather provide her credentials and the backend will automatically check identity, access level, and authentication. For more information on this check the [APIs repository](https://github.com/CETAC-NetworkDefenders/cetac-apis). 

| Login Screen | Successful Login |
|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1S6q-MMeI-KLGS6Uo9xyOo0CA5t44aff_)  |  ![image](https://drive.google.com/uc?export=view&id=1CovCT8rs7l-F9nIni83zoIiAxWUtokZj)  |

### Staff Listing 

The following screens show the user listing by access level. In order to implement this, a Segment Controller along with a Container View, which has a Table View embedded was used. The information of the table is programatically changed each time the admin selects a different access level. Note that the users are separated in sections by alphabetical order. 

| Thanatologist List | Administrators List | Administrator Support List |
|---|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1KHe06l7iMj9xkKpZiaXHsyV9JN2gGMBJ)  |  ![image](https://drive.google.com/uc?export=view&id=1YUABysxqry2rvL9gLvDL9pFIHHG7MkuE)  |  ![image](https://drive.google.com/uc?export=view&id=10cQQCKAJiUBVCrURUvZ6d8L8TPDciRBr) |

### Staff detail, edition, and creation

When the admin is looking at the staff table, she can select a specific user to see its details, as well as to edit the information. Furthermore, it is possible to add a new user to the DB. Note that only users with Admin access level, and not Admin Support, are allowed to edit or add information. For extra security and data consistency, each field in the user edition or creation views includes validation, in most cases enforced using a Regular Expression. 

| View User Details | Edit User | Create User |
|---|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1GAbY8qBHngM5UBOs0lyeLz4xF4MuMMd5) | ![image](https://drive.google.com/uc?export=view&id=1WbsLDs-gn3o8qyapYPQtRbdIGfgC3TUC)  |  ![image](https://drive.google.com/uc?export=view&id=1b8Ad3s9C01qvMWpfkCtQQuU8pgJ6GPdt) |

### KPIs Reports

Finally, the administrator is able to see several reports of some Key Performance Indicators, such as the number of attended users, the total revenue (optional recovery fee), and the main motives for attention. All of this data is shown boh globally, and per thanatologist. In this way it is possible to asses not only the organization´s state, but also the performance of each individual staff. Furthermore, the timeframe of the reports can be changed to yearly, monthly, or weekly, to identify patterns and changes. Overall, seven different types of reports are shown in the app. Here are some examples: 

| Weekly Service Type Report  | Montly Session Motive Report | Weekly Session Tools Report | Yearly Users per Thanatologist Report |
|---|---|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1OGuHF7nsCDTamR58pt7KT_NrQmUSwBES) | ![image](https://drive.google.com/uc?export=view&id=1cnyn28JWDZFM17JVBT1Fo7PklZc4t9Tv) | ![image](https://drive.google.com/uc?export=view&id=1Fb3m8AOI8Nl7uc1PxW0aHdCRE6GpW1ZM) | ![image](https://drive.google.com/uc?export=view&id=11wrXaBh8XzRfx7VjJqF0iafsfyu6D_kE) | 

## Thanatologist Area

The thanatologist should be able to manage her own users, add new ones, and add sessions to them. It should also be possible to close and reopen a patient´s record, in case they return to the clinic. 

### Users Management

First, the thanatologist must be able to see a list of all her active users, and when she clicks on one, a new screen should indicate the details. On the left side of this segmented control, the personal information is displayed. Also, there is a screen to create a new user, which has field validations, and a screen to repoen a closed record. 

| View User List | View User Information | Create a new User | Reopen Record |
|---|---|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1Fr_KpDCfx_KQhaO6_Z84RODGFCXXm0pJ) | ![image](https://drive.google.com/uc?export=view&id=1MrFsAWUpNQ-RsaJbrtBZ4zq6H-NgkP5O) | ![image](https://drive.google.com/uc?export=view&id=1pnPOUqAF3BOFKE52qhfzmmg8Mj_3G8Kd) | ![image](https://drive.google.com/uc?export=view&id=1NIyvvjGUN0Vv-J8Uo8zmTCTaZizATVY8) | 


### Sessions Management

Once that the thanatologist accessed a user information section, she can also manage the user´s sessions. On the information screen, the left part of the segmented controller displays a table with all the sessions associated to the user. When the thanatologist selects one, another screen shows the information from that specific session, so that it is possible to review the patient`s history and analyze her progress. Also, in the upper part of the table screen, it is possible to add a new session associated with the user. It is not possible to edit a session, since this could lead to a loss of information integrity. 


| View Session List | View Session Detail | Create Session |
|---|---|---|
| ![image](https://drive.google.com/uc?export=view&id=1NIyvvjGUN0Vv-J8Uo8zmTCTaZizATVY8) | ![image](https://drive.google.com/uc?export=view&id=1lOK7LXVZ2xYVHtDqaU2sIVTeQm6gJKMQ)  |  ![image](https://drive.google.com/uc?export=view&id=1xy2NR6Dg-7rNmozvHXHpmHDEDqhRXKXg) |
